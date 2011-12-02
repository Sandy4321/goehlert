class AddSportAndLeagueToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :sport, :string
    add_column :teams, :league, :string
    Team.all.each { |team| team.update_attributes! :sport => 'mlb', :league => 'nl' }
  end
end
