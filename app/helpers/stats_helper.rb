module StatsHelper
	def response_success?
		response.status == 200
	end
	
	def result_count?
		params[:result_count].to_i > 0
	end
	
	def format_decimal(decimal, precision, leading_zero=true)
		str = "%.#{ precision }f" % decimal
		if leading_zero == false
			str.sub!(/^0/, '')
		end
		str
	end
end
