class Team < ActiveRecord::Base
  validates :name,  :presence => true,
                    :uniqueness => { :case_sensitive => false }
  validates :abbr,  :presence => true,
                    :uniqueness => { :case_sensitive => false }
  validates :location, :presence => true
  
  has_many :stats
end
