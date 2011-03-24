class Linux
  attr_accessor :qdb, :dirs, :params
  
  def initialize(params)
    r = Random.new("username".hash)
    @params = params
    @files = Array.new
    @dirs = Array.new
    currdir =  Directory.new(".")
    predir = Directory.new("..")
    @dirs << currdir << predir
    
    @qdb = QuestionDatabase.new(r, predir, currdir, params)
  end
  
  def length
    @qdb.questions.length + @dirs.length
  end
end

class FileNames
  attr_accessor :names, :ends, :rand
  def initialize(rand)
    @rand = rand
    @names = ["readme", "database", "compiler", "solutions", "trackingdata", "breadcrumbs", "site", "origin", "training", "backstory"]
    @ends = [".txt", ".file", "", ".c", ".java", ".class", ".sql"]
  end
  
  def getRandomName
    name = @names[@rand.rand(@names.length)]
    #@names = names - [name]
    name = name + @ends[@rand.rand(@ends.length)]
  end
end

class Directory
  attr_accessor :attr, :name
  def initialize(name)
    @attr = ['d','r','w','x','r','w','x','r','w','t']
    @name = name
  end
end

class Question
  attr_accessor :attr, :name, :owner, :group  , :question, :answer, :checked, :correct
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
  attr_accessor :questions, :rand, :predir, :currdir, :nbrCorrect
  def initialize(rand, predir, currdir, params)
    @rand = rand
    @predir = predir
    @currdir = currdir
    @questions = Array.new
    self.generateQuestions(params)
    @nbrCorrect = 0
    @questions.each do |q|
      if q.correct == true then
        @nbrCorrect = @nbrCorrect + 1
      end
    end
    
  end
  
  def generateQuestions(params)
    filenamer = FileNames.new(rand)
    
    filename = filenamer.getRandomName
    @questions << Question.new(filename, "Can Alice read #{filename}?", true, ['-','r','w','x','r','w','x','r','w','x'], "Alice", "Students", self.isChecked?(filename, params))
    filename = filenamer.getRandomName
    @questions << Question.new(filename, "Can Bob read #{filename}?", true, ['-','r','w','x','r','w','x','r','w','x'], "Alice", "Students", self.isChecked?(filename, params))
    filename = filenamer.getRandomName
    @questions << Question.new(filename, "Can Donatello write to #{filename}?", false, ['-','-','-','x','r','w','x','r','w','x'], "Donatello", "Students", self.isChecked?(filename, params))

  end
  
  def isChecked?(filename, params)
    if params[filename].nil? then
      return ""
    else
      return params[filename][filename] == 'true'
    end
  end
  
  def getRandomQuestion
    if @questions.length > 0 then
      return @questions[@rand.rand(questions.length)]
    end
  end
end