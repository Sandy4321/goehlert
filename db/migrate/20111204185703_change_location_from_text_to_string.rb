class ChangeLocationFromTextToString < ActiveRecord::Migration
  def change
  	change_table :stats do |t| 
  		t.change :location, :string 
  	end
  	  	
  	change_table :teams do |t| 
  		t.change :location, :string 
  	end
  end
end
