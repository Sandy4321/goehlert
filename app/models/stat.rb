class Stat < ActiveRecord::Base
  validates :team_id, :presence => true
  validates :year, :presence => true
            # need to validate only one year per team_id 
  validates :goehlert_score, :presence => true
  validates :reg_season_win, :presence => true
  validates :playoff_win, :presence => true
  
  belongs_to :team
end
