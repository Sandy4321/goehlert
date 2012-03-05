module ApplicationHelper  
  def cap_first(str)
  	conjunctions = ['or', 'of', 'and']
    words = str.split(' ')
    words.each do |word|
    	if !conjunctions.include?(word) 
    		word.to_s.capitalize! 
    	end
    end
    words.join(' ')
  end
end
