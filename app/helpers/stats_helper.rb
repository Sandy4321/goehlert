module StatsHelper
  def response_success?
    response.status === 200
  end
end
