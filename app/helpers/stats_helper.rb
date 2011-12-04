module StatsHelper
  def response_success?
    response.status === 200
  end
  
  def displayed_stats
  	['g_score', 'reg_season_rec', 'playoff_app']
  end
end
