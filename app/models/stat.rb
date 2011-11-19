class Stat < ActiveRecord::Base
  validates :year,  :presence => true
  validates :team_id, :presence => true,
                      :uniqueness => {  :scope => :year,
                                        :message => 'can only have one set of stats per year'}
  validates :goehlert_score, :presence => true
  validates :reg_season_win, :presence => true
  validates :playoff_win, :presence => true
  
  belongs_to :team
end
