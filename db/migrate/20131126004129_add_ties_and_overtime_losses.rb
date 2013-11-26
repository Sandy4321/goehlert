class AddTiesAndOvertimeLosses < ActiveRecord::Migration
  def change
    add_column :stats, :ties, :integer
    add_column :stats, :overtime_losses, :integer
  end
end
