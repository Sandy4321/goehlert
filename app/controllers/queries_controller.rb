class QueriesController < ApplicationController
  def index
    @all_teams = Team.all
    @first_team_stats = Team.find(3).stats
    @request = request
  end
end