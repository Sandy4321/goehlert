class TeamsController < ApplicationController
  def index
    @teams_alpha = Team.order(:location)
  end

  def show
  	@team = Team.find(params[:id])
  	@team_stats = @team.stats

    if request.xhr?
      render json: @team
    end
  end
end
