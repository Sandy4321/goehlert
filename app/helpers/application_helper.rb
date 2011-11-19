module ApplicationHelper  
  def capitalize_first str
    words = str.split(' ')
    words.each { |word| word.to_s.capitalize! }.join(' ')
  end
end
