class StatsController < ApplicationController
	def measured_stat
		if !params[:measured_stat].nil? 
			params[:measured_stat].to_s
		else 
			nil
		end
	end
		
	# Raw stats
	def raw  	
		def result_count
			params[:result_count].to_i
		end 
		
		@measured_stat = measured_stat
		@raw_results = Stat.where(:year => params[:start_year]..params[:end_year]).limit(result_count).reorder(measured_stat + ' DESC')
	end
	
	# Compiled stats
	def compiled
		stat = measured_stat()
		@team = Team.all
		
		if !stat.nil?
			@compiled_results = Stat.compiled_stats(stat, params)
		end
	end
end
