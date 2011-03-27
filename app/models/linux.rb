class Linux
  attr_accessor :qdb, :dirs, :name
  
  def initialize(rand, name)
    @dirs = Array.new
    @qdb = QuestionDatabase.new(rand)
    @name = name
  end
  
  def length
    @qdb.questions.length + @dirs.length
  end
end


class Directory
  attr_accessor :name, :attr, :owner, :group
  def initialize(name, attr, owner, group)
    @name = name
    @attr = attr
    @owner = owner
    @group = group
    @attr = attr
  end
end

class Question
  attr_accessor :attr, :name, :owner, :group, :question, :answer, :checked, :correct
  def initialize(name, question, answer, attr, owner, group, checked)
    @name = name
    @question = question
    @answer = answer
    @attr = attr
    @owner = owner
    @group = group
    @checked = checked
    @correct = checked == answer
  end
end


class QuestionDatabase
  attr_accessor :questions, :rand
  def initialize(rand)
    @rand = rand
    @questions = Array.new
  end

  def length
    if @questions.length > 0 then
      return @questions.length
    else
      return 0.1
    end
  end

  def nbrCorrect?
    @nbrCorrect = 0
    @questions.each do |q|
      if q.correct == true then
        @nbrCorrect = @nbrCorrect + 1
      end
    end
    return @nbrCorrect
  end
  
  def add(question)
     @questions << question
  end
  
  def isChecked?(filename, params)
    if params[filename].nil? then
      return ""
    else
      return params[filename][filename] == 'true'
    end
  end
end