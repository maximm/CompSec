class Winfile
  attr_accessor :dacl, :filename, :questions, :tokens
  
  
  def initialize(filename)
    @filename = filename
    @dacl = Array.new
    @questions = Array.new
    @tokens = Array.new
  end
  
  def randomizeQuestions(nbr, questions, rand)
      nbr.times do
      question = questions[rand.rand(questions.length)]
      questions.delete_if { |q| q.name == question.name }
      @questions << question
    end
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