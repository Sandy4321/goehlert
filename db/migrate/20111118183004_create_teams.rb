class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :abbr
      t.text :location

      t.timestamps
    end
  end
end
