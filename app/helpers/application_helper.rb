module ApplicationHelper
  def body_classes
    controller_name
  end

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
