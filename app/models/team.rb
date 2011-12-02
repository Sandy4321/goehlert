class Team < ActiveRecord::Base
  validates :sport, :presence => true
  validates :league, :presence => true
  validates :name, :presence => true,
                   :uniqueness => { :case_sensitive => false }
  validates :abbr, :presence => true,
                   :uniqueness => { :case_sensitive => false }
  validates :location, :presence => true
  
  has_many :stats, :order => 'year DESC'
end

######################
# TEAM COLUMNS NEEDED
# sport
# name x
# prior_name?
# abbr x
# location x
# prior_location?
# league
# division?
# stats (foreign key)