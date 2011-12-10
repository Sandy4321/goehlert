module StatsHelper
  def response_success?
    response.status === 200
  end
  
  def result_count?
  	params[:result_count].to_i > 0
  end
end
