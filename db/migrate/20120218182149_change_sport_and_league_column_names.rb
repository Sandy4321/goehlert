class ChangeSportAndLeagueColumnNames < ActiveRecord::Migration
	def change
		change_table :teams do |t|
			t.rename :league, :conference
			t.rename :sport, :league
		end
	end
end
