class ChangeLeagueColumnNameOnStats < ActiveRecord::Migration
	def change
		change_table :stats do |t|
			t.rename :league, :conference
		end
	end
end
