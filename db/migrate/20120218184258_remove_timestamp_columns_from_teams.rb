class RemoveTimestampColumnsFromTeams < ActiveRecord::Migration
	def change
		change_table :teams do |t|
			t.remove :created_at
			t.remove :updated_at
		end
	end
end
