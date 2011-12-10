class Stat < ActiveRecord::Base
  validates :year, :presence => true 
  validates :team_id, :presence => true,
                      :uniqueness => { :scope => :year,
                                       :message => 'can only have one set of stats per year' }
  validates :wins, :presence => true,
  								 :numericality => { :only_integer => true }
  validates :losses, :presence => true,
  									 :numericality => { :only_integer => true }
  validates :reg_season_rec, :presence => true,
  													 :numericality => { :greater_than_or_equal_to => 0,
  													 										:less_than_or_equal_to => 1 }
  validates :wildcard, :presence => true,
  										 :numericality => { :only_integer => true },
  										 :inclusion => { :in => [0, 1] }
  validates :playoff_app, :presence => true,
  												:numericality => { :only_integer => true },
  												:inclusion => { :in => [0, 1] }
  validates :div_champ, :presence => true,
  											:numericality => { :only_integer => true },
  											:inclusion => { :in => [0, 1] }
  validates :league_champ, :presence => true,
  												 :numericality => { :only_integer => true },
  												 :inclusion => { :in => [0, 1] }
  validates :champ, :presence => true,
  								  :numericality => { :only_integer => true },
  									:inclusion => { :in => [0, 1] }
  validates :g_score, :presence => true,
  										:numericality => true
  validates :name, :format => { :with => /[a-zA-Z]/ },
  								 :allow_blank => true
  validates :location, :format => { :with => /[a-zA-Z]/ },
  										 :allow_blank => true
  validates :league, :format => { :with => /[a-zA-Z]/ },
  									 :allow_blank => true
  validates :division, :format => { :with => /[a-zA-Z]/ },
  									 :allow_blank => true
  belongs_to :team
  
  def self.compiled_stats(measured_stat, params)
  	compiled_stats = []
  	stats_by_team = []
  	date_range = params[:start_year]..params[:end_year]
  	stats_pool = Stat.where(:year => date_range).to_a
  	team_ids = get_team_ids(stats_pool)
  	team_ids.each do |id|
  		team = 
  		{
  			:id => id,
  			:location => Team.find(id).location,
  			:name => Team.find(id).name,
	  		:abbr => Team.find(id).abbr,
	  		:sport => Team.find(id).sport,
	  		:league => Team.find(id).league,
	  		:division => Team.find(id).division,
	  		:raw_stats => [],
				:compiled_stats => {}
  		}
  		stats_by_team.push(team)
  	end
  	stats_pool.each do |stat|
			stats_by_team.each do |team_stats|
				if team_stats[:id] == stat.team_id
					team_stats[:raw_stats].push(stat)
				end
			end
   	end
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
  		team[:raw_stats].each do |raw|
  			compiled = team[:compiled_stats]
  			compiled[:g_score] += raw.g_score
  			compiled[:reg_season_rec] += raw.reg_season_rec  		
  			compiled[:wins] += raw.wins	
  			compiled[:losses] += raw.losses	
  			compiled[:champ] += raw.champ	
  			compiled[:league_champ] += raw.league_champ	
  			compiled[:div_champ] += raw.div_champ	
  			compiled[:wildcard] += raw.wildcard	
  			compiled[:notes] += raw.notes if !raw.notes.nil?
  		end
  	end
  	stats_by_team.each do |team|
  		compiled_team = 
  		{
  			:name => team[:name],
  			:abbr => team[:abbr],
  			:g_score => team[:compiled_stats][:g_score],
  			:reg_season_rec => team[:compiled_stats][:reg_season_rec],
  			:wins => team[:compiled_stats][:wins],
  			:losses => team[:compiled_stats][:losses],
  			:champ => team[:compiled_stats][:champ],
  			:league_champ => team[:compiled_stats][:league_champ],
  			:div_champ => team[:compiled_stats][:div_champ],
  			:wildcard => team[:compiled_stats][:wildcard]
  		}
  		compiled_stats.push(compiled_team)
  	end
  	compiled_stats
  end
  
private
  	
	def self.get_team_ids(stats_pool)
  	team_ids = []
  	stats_pool.each do |stat| 
  		if !team_ids.include?(stat.team_id)
  			team_ids.push(stat.team_id)
  		end
  	end
  	team_ids
	end
end




















