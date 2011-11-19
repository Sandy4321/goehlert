task :add_stats do
  years = (2011..2005)
  i = 9
  team_id = 4
  years.each do |year|
    Stat.create!(:year => year, :goehlert_score => i, :reg_season_win => i/10, :playoff_win => i/10, :team_id => team_id)
    i -= 1
  end
end