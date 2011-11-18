class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.date :year
      t.decimal :goehlert_score
      t.decimal :reg_season_win
      t.decimal :playoff_win
      t.references :team

      t.timestamps
    end
    add_index :stats, :team_id
  end
end
