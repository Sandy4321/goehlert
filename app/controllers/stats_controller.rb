class StatsController < ApplicationController
	def index  	
		def result_count
			params[:result_count].to_i
		end 
		
		def measured_stat
			stat = params[:measured_stat].to_s
			"#{ stat } DESC" if !params[:measured_stat].nil? else ''
		end
		
		@measured_stat = self.measured_stat
		@results = Stat.where(:year => (params[:start_year])..(params[:end_year])).limit(result_count).reorder(measured_stat)
	end
end
