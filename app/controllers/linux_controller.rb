class LinuxController < ApplicationController
  def index
    #@linux = Linux.new(params)
  end
  
  def create
    rand = Random.new("username".hash)
    filenamer = Filenames.new(rand)
    @parts = Array.new
    
    # Del 1
    part = Linux.new(rand, "Part 1 - Read / Write / Execute / Listing Directories")
    part.dirs << Directory.new(".", ['d','r','w','x','r','w','x','r','w','-'], "Bobby", "Teachers") 
    part.dirs << Directory.new("..", ['d','r','w','x','r','w','x','r','w','x'], "Bobby", "Teachers") 
    
    
    # Read
    questions = Array.new
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Alice (Students) read #{filename}?", true, ['-','r','w','x','r','w','x','r','-','-'], "Bobby", "Teachers", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Alice (Students) read #{filename}?", false, ['-','-','w','x','-','w','x','r','w','x'], "John", "Parents", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Alice (Students) read #{filename}?", true, ['-','-','w','x','r','-','-','-','w','-'], "Mindy", "Students", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Bobby (Teachers) read #{filename}?", false, ['-','-','w','x','r','w','x','r','w','x'], "Bobby", "Teachers", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can John (Parents) read #{filename}?", false, ['-','r','w','-','r','-','-','r','w','x'], "Bobby", "Teachers", params)
    part.randomizeQuestions(2, questions, rand)

    # Write
    questions = Array.new
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Bobby (Teachers) write to #{filename}?", true, ['-','r','w','-','-','w','-','r','-','x'], "Bobby", "Teachers", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Sarah (Teachers) write to #{filename}?", false, ['-','r','w','-','r','-','x','r','w','x'], "Bobby", "Teachers", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Alice (Students) write to #{filename}?", true, ['-','r','w','-','r','w','x','r','w','x'], "Mindy", "Students", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Sarah (Teachers) write to #{filename}?", true, ['-','r','-','-','r','w','x','-','-','-'], "Bobby", "Teachers", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can John (Parents) write to #{filename}?", false, ['-','r','w','-','-','-','-','r','w','x'], "Bobby", "Teachers", params)
    part.randomizeQuestions(2, questions, rand)
    
    # Execute
    questions = Array.new
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Bobby (Teachers) execute #{filename}?", true, ['-','-','-','x','-','w','x','r','-','x'], "Bobby", "Teachers", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Sarah (Teachers) execute #{filename}?", false, ['-','r','w','-','r','-','x','-','w','x'], "Sarah", "Teachers", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can Alice (Students) execute #{filename}?", true, ['-','r','w','-','r','w','x','r','w','-'], "Mindy", "Students", params)
    filename = "script.sh"
    questions << Question.new(filename, "Can Sarah (Teachers) execute the shell script #{filename}?", false, ['-','r','w','x','-','w','x','r','w','x'], "Bobby", "Teachers", params)
    filename = filenamer.getRandomName
    questions << Question.new(filename, "Can John (Parents) execute #{filename}?", false, ['-','r','w','x','-','-','x','r','w','x'], "Bobby", "Teachers", params)
    part.randomizeQuestions(2, questions, rand)
    
    # Directory Listing
    questions = Array.new
    filename = "Pictures"
    questions << Question.new(filename, "Can Bobby (Teachers) list the contents of the current directory #{filename} using 'ls'?", true, ['d','r','-','-','r','w','x','r','w','x'], "Bobby", "Teachers", params)
    filename = "Videos"
    questions << Question.new(filename, "Can Mindy (Students) list the contents of the current directory #{filename} using 'ls'?", false, ['d','-','-','x','r','w','x','-','w','x'], "Sarah", "Teachers", params)
    filename = "Previous Exams"
    questions << Question.new(filename, "Can Alice (Students) list the contents of the current directory #{filename} using 'ls -l'?", false, ['d','r','-','-','r','w','x','r','-','x'], "Alice", "Students", params)
    filename = "Tools"
    questions << Question.new(filename, "Can Alice (Students) list the contents of the current directory #{filename} using 'ls -l'?", true, ['d','r','-','-','r','-','x','r','-','x'], "Mindy", "Students", params)
    filename = "Java for newbies"
    questions << Question.new(filename, "Can Bobby (Teachers) list the contents of the current directory #{filename} using 'ls -l'?", true, ['d','r','-','-','r','-','x','r','-','x'], "John", "Parents", params)
    part.randomizeQuestions(2, questions, rand)    
    
    part.qdb.questions.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    @parts << part
    
    
    # Del 2
    part = Linux.new(rand, "Part 2 - Create / Move / Remove")
    @parts << part
        
    
    # Del 3
    part = Linux.new(rand, "Part 3 - Sticky Bits")
    @parts << part


    @total = 0
    @totalCorrect = 0
    @parts.each do |linux|
      @total += linux.qdb.questions.length
      @totalCorrect += linux.qdb.nbrCorrect?
    end    
  end
end
