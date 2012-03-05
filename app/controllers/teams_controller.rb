class TeamsController < ApplicationController
  def index
    @teams_alpha = Team.order(:location)
  end
  
  def show
  	@team = Team.find(params[:id])
  	@team_stats = @team.stats
  end
end
