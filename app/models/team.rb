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

  def self.ordered
    order('location ASC', 'name ASC')
  end

  def to_s
    "#{location.titleize} #{name.titleize}"
  end
end
