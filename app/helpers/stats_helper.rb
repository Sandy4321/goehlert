module StatsHelper
  def response_success?
    response.status === 200
  end
  
  def displayed_stats
  	['goehlert_score', 'reg_season_win', 'playoff_win']
  end
end
