class StatsController < ApplicationController
  def index
    @top_goehlert_2011 = Stat.where('year' => 2011).reorder('goehlert_score DESC')
  end
end
