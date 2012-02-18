class Team < ActiveRecord::Base
  validates :league, :presence => true
  validates :conference, :presence => true
  validates :division, :presence => true
  validates :name, :presence => true,
                   :uniqueness => { :case_sensitive => false }
  validates :abbr, :presence => true,
                   :uniqueness => { :case_sensitive => false }
  validates :location, :presence => true,
  										 :format => { :with => /[a-zA-Z]/ }
  
  has_many :stats, :order => 'year DESC'
end

######################
# TEAM COLUMNS NEEDED
# sport
# name x
# abbr x
# location x
# league
# division
# stats (foreign key)