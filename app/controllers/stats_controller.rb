class StatsController < ApplicationController
	def index  	
		def result_count
			params[:result_count].to_i
		end 
		
		def measured_stat
			params[:measured_stat].to_s
		end
		
		@measured_stat = self.measured_stat
		@results = Stat.where(:year => (params[:start_year])..(params[:end_year])).limit(result_count).reorder("#{ measured_stat } DESC")
	end
end
