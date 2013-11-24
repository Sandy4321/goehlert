class Stat < ActiveRecord::Base
	validates :year, :presence => true
	validates :team_id, :presence => true, :uniqueness => { :scope => :year, :message => 'can only have one set of stats per year' }
	validates :wins, :presence => true, :numericality => { :only_integer => true }
	validates :losses, :presence => true, :numericality => { :only_integer => true }
	validates :reg_season_rec, :presence => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1 }
	validates :wildcard, :presence => true, :numericality => { :only_integer => true }, :inclusion => { :in => [0, 1] }
	validates :playoff_app, :presence => true, :numericality => { :only_integer => true }, :inclusion => { :in => [0, 1] }
	validates :div_champ, :presence => true, :numericality => { :only_integer => true }, :inclusion => { :in => [0, 1] }
	validates :league_champ, :presence => true, :numericality => { :only_integer => true }, :inclusion => { :in => [0, 1] }
	validates :champ, :presence => true, :numericality => { :only_integer => true }, :inclusion => { :in => [0, 1] }
	validates :g_score, :presence => true, :numericality => true
	validates :name, :format => { :with => /[a-zA-Z]/ }, :allow_blank => true
	validates :location, :format => { :with => /[a-zA-Z]/ }, :allow_blank => true
	validates :conference, :format => { :with => /[a-zA-Z]/ }, :allow_blank => true
	validates :division, :format => { :with => /[a-zA-Z]/ }, :allow_blank => true

	belongs_to :team

  def self.years
    pluck(:year).uniq.sort
  end

	def date_range(options)
		options[:start_year]..options[:end_year]
	end

  def selected_league_team_ids(options)
    selected_team_ids = []

    selected_leagues = options[:league].select { |k, v| v == '1' }.map{ |k, v| k }

    Team.all.each do |team|
      if selected_leagues.include?(team.league)
        selected_team_ids << team.id
      end
    end

    selected_team_ids
  end

	def compiled_stats(measured_stat, options)
		compiled_stats = []
		stats_by_team = []

		stats_pool = Stat.where(:year => date_range(options), :team_id => selected_league_team_ids(options)).to_a
		team_ids = get_team_ids(stats_pool)

		# Create a hash for each team, push to stats_by_team array.
		team_ids.each do |id|
			team =
			{
				:id => id,
				:location => Team.find(id).location,
				:name => Team.find(id).name,
		  		:abbr => Team.find(id).abbr,
		  		:league => Team.find(id).league,
		  		:conference => Team.find(id).conference,
		  		:division => Team.find(id).division,
		  		:raw_stats => [],
				:compiled_stats => {}
			}
			stats_by_team.push(team)
		end

		# Push each set of stats for a team id to that team's hash, into its raw stats array.
		stats_pool.each do |stat|
			stats_by_team.each do |team_stats|
				if team_stats[:id] == stat.team_id
					team_stats[:raw_stats].push(stat)
				end
			end
		end

		# Create compiled stats hash for each team.
		stats_by_team.each do |team|
			team[:compiled_stats] =
			{
				:g_score => 0,
				:reg_season_rec => 0,
				:wins => 0,
				:losses => 0,
				:champ => 0,
				:league_champ => 0,
				:div_champ => 0,
				:wildcard => 0,
				:playoff_app => 0,
				:notes => ''
			}

			# Add up the raw stats for each team into that team's compiled stats hash.
			compiled = team[:compiled_stats]

			team[:raw_stats].each do |raw|
				compiled[:g_score] += raw.g_score
				compiled[:wins] += raw.wins
				compiled[:losses] += raw.losses
				compiled[:champ] += raw.champ
				compiled[:league_champ] += raw.league_champ
				compiled[:div_champ] += raw.div_champ
				compiled[:wildcard] += raw.wildcard
				compiled[:playoff_app] += raw.playoff_app
				compiled[:notes] += (" // " + raw.notes) if !raw.notes.nil?
			end

			# Calculate overall season record based on compiled wins and losses.
			total_games = compiled[:wins].to_f + compiled[:losses].to_f
			compiled[:reg_season_rec] = (compiled[:wins].to_f / total_games).round(3)
		end

		# Create a new compiled team hash with compiled stats and add each compiled team to the results array.
		# This feels redundant; initially I tried to just remove the raw stats from each team but was
		# getting funny results when doing so. There should be a more concise way to do this.
		stats_by_team.each do |team|
			compiled_team =
			{
				:id => team[:id],
				:name => team[:name],
				:abbr => team[:abbr],
				:league => team[:league],
				:g_score => team[:compiled_stats][:g_score],
				:avg_g_score => team[:compiled_stats][:g_score]/date_range(options).count,
				:reg_season_rec => team[:compiled_stats][:reg_season_rec],
				:wins => team[:compiled_stats][:wins],
				:losses => team[:compiled_stats][:losses],
				:champ => team[:compiled_stats][:champ],
				:league_champ => team[:compiled_stats][:league_champ],
				:playoff_app => team[:compiled_stats][:playoff_app],
				:div_champ => team[:compiled_stats][:div_champ],
				:wildcard => team[:compiled_stats][:wildcard],
				:notes => team[:compiled_stats][:notes]
			}
			compiled_stats.push(compiled_team)
		end
		# Return array of compiled team stats.
		compiled_stats
	end

  # Get list of unique team ids from all stats queried.
	def get_team_ids(stats_pool)
	  	team_ids = []
	  	stats_pool.each do |stat|
	  		if !team_ids.include?(stat.team_id)
	  			team_ids.push(stat.team_id)
	  		end
	  	end
	  	team_ids
	end
end
