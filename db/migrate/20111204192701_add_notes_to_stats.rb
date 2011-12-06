class AddNotesToStats < ActiveRecord::Migration
  def change
    add_column :stats, :notes, :string
  end
end
