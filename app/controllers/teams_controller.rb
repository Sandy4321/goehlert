class TeamsController < ApplicationController
  def index
    @teams_alpha = Team.order(params[:location])
  end
end
