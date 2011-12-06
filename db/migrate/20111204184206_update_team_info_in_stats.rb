class UpdateTeamInfoInStats < ActiveRecord::Migration
	def change
		change_table :stats do |t|
			t.rename :as_name, :name
			t.rename :at_location, :location
			t.string :league
			t.string :division
		end
  end
end
