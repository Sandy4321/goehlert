class Stat < ActiveRecord::Base
  validates :year, :presence => true, 
  								 :numericality => { :only_integer => true }
  validates :team_id, :presence => true,
                      :uniqueness => { :scope => :year,
                                       :message => 'can only have one set of stats per year' }
  validates :wins, :presence => true,
  								 :numericality => { :only_integer => true }
  validates :losses, :presence => true,
  									 :numericality => { :only_integer => true }
  validates :reg_season_rec, :presence => true,
  													 :numericality => { :greater_than_or_equal_to => 0,
  													 										:less_than_or_equal_to => 1 }
  validates :wildcard, :presence => true,
  										 :numericality => { :only_integer => true },
  										 :inclusion => { :in => [0, 1] }
  validates :playoff_app, :presence => true,
  												:numericality => { :only_integer => true },
  												:inclusion => { :in => [0, 1] }
  validates :div_champ, :presence => true,
  											:numericality => { :only_integer => true },
  											:inclusion => { :in => [0, 1] }
  validates :league_champ, :presence => true,
  												 :numericality => { :only_integer => true },
  												 :inclusion => { :in => [0, 1] }
  validates :champ, :presence => true,
  								  :numericality => { :only_integer => true },
  									:inclusion => { :in => [0, 1] }
  validates :g_score, :presence => true,
  										:numericality => true
  validates :as_name, :allow_blank => true,
  									  :format => { :with => /[a-zA-Z]/ }
  validates :at_location, :allow_blank => true,
  									  		:format => { :with => /[a-zA-Z]/ }
  
  belongs_to :team
end

######################
# STAT COLUMNS NEEDED
# year x
# wins (integer)
# losses (integer)
# reg_season_rec --> rename from reg_season_win
# wildcard (integer, 1/0)
# playoff_app (integer) --> remove playoff_win
# div_champ (integer)
# league_champ (integer) 
# champ (integer)
# g_score --> rename from goehlert_score
# num_seasons (integer)
# avg_g_score (decimal)
# as_name (string)












# at_location (text)