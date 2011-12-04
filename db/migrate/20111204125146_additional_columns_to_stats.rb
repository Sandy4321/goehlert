class AdditionalColumnsToStats < ActiveRecord::Migration
	def change
		change_table :stats do |t|
			t.integer :wins
			t.integer :losses
			t.rename :reg_season_win, :reg_season_rec
			t.integer :wildcard
			t.remove :playoff_win
			t.integer :playoff_app
			t.integer :div_champ
			t.integer :league_champ
			t.integer :champ
			t.rename :goehlert_score, :g_score
			t.integer :num_seasons
			t.decimal :avg_g_score
			t.string :as_name
			t.text :at_location
		end
	end
end
