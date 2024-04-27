class BaseView
  def ask_for(something)
    puts "What is the #{something}?"
    gets.chomp
  end
end
