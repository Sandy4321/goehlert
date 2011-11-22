module ApplicationHelper  
  def cap_first str
    words = str.split(' ')
    words.each { |word| word.to_s.capitalize! }.join(' ')
  end
end
