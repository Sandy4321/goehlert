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
		stat = measured_stat()
		result_count = params[:result_count].to_i
		if !stat.nil?
			@raw_results = Stat.where(:year => params[:start_year]..params[:end_year]).limit(result_count).reorder(measured_stat + ' DESC')
		end
	end
	
	# Compiled stats
	def compiled
		stat = measured_stat()
		result_count = params[:result_count].to_i
		
		if !stat.nil?
			stat_symbol = stat.to_sym
			@compiled_results = Stat.compiled_stats(stat, params).sort_by { |team| team[stat_symbol] }.reverse!.first(result_count)
		end
	end
end
