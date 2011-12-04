class RemoveColumnsFromStats < ActiveRecord::Migration
  def up
    remove_column :stats, :avg_g_score
    remove_column :stats, :num_seasons
  end

  def down
    add_column :stats, :num_seasons, :integer 
    add_column :stats, :avg_g_score, :decimal
  end
end
