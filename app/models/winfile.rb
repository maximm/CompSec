class Winfile
  attr_accessor :dacl, :filename, :questions
  
  def initialize(filename)
    @filename = filename
    @dacl = Array.new
    @questions = Array.new

  end
end

class WinQuestion
  attr_accessor :question, :name, :answer, :checked, :correct
  
  def initialize(question, name, answer, params)
    @question = question
    @name = name
    @answer = answer
    @checked = self.isChecked?(name, params)
    @correct = @checked == @answer
  end
  
  def isChecked?(filename, params)
    if params[filename].nil? then
      return ""
    else
      return params[filename][filename] == 'true'
    end
  end  
end
