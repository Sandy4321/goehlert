class Stat < ActiveRecord::Base
  validates :year, :presence => true 
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
  validates :name, :format => { :with => /[a-zA-Z]/ },
  								 :allow_blank => true
  validates :location, :format => { :with => /[a-zA-Z]/ },
  										 :allow_blank => true
  validates :league, :format => { :with => /[a-zA-Z]/ },
  									 :allow_blank => true
  validates :division, :format => { :with => /[a-zA-Z]/ },
  									 :allow_blank => true
  belongs_to :team
  
  def self.compiled_stats(measured_stat, params)
  	date_range = params[:start_year]..params[:end_year]
  	
  	Stat.where(:year => params[:start_year]..params[:end_year]).reorder(measured_stat + ' DESC').limit(params[:result_count])
  end
end
