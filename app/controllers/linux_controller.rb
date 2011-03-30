class LinuxController < ApplicationController
  def index
    #@linux = Linux.new(params)
  end
  
  def create
    rand = Random.new("username".hash)
    namer = Filenames.new(rand)
    @parts = Array.new
    student1 = namer.getRandomUserName("Students") #Alice
    student2 = namer.getRandomUserName("Students") #Mindy
    teacher1 = namer.getRandomUserName("Teachers") #Bobby
    teacher2 = namer.getRandomUserName("Teachers") #Sarah
    parent1 = namer.getRandomUserName("Parents") #John
    parent2 = namer.getRandomUserName("Parents")
    
    # Del 1
    part = Linux.new(rand, "Part 1 - Read / Write / Execute / Listing Directories")
    part.dirs << Directory.new(".", ['d','r','w','x','r','w','x','r','w','-'], teacher1) 
    part.dirs << Directory.new("..", ['d','r','w','x','r','w','x','r','w','x'], teacher1) 
    
    
    # Read
    questions = Array.new
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher2.to_s} read #{filename}?", true, ['-','r','w','x','r','w','x','r','-','-'], teacher1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{student1.to_s} read #{filename}?", false, ['-','-','w','x','-','w','x','r','w','x'], parent1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher1.to_s} read #{filename}?", true, ['-','-','w','x','r','-','-','r','w','-'], student2, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher1.to_s} read #{filename}?", false, ['-','-','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{parent1.to_s} read #{filename}?", false, ['-','r','w','-','r','-','-','r','w','x'], teacher1, params)
    part.randomizeQuestions(2, questions, rand)

    # Write
    questions = Array.new
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher1.to_s} write to #{filename}?", true, ['-','r','w','-','-','w','-','r','-','x'], teacher1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher2.to_s} write to #{filename}?", false, ['-','r','w','-','r','-','x','r','w','x'], teacher1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{student1.to_s} write to #{filename}?", false, ['-','r','w','-','r','w','x','r','w','x'], student2, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher2.to_s} write to #{filename}?", true, ['-','r','-','-','r','w','x','-','-','-'], teacher1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher1.to_s} write to #{filename}?", true, ['-','r','w','-','-','-','-','r','w','x'], teacher1, params)
    part.randomizeQuestions(2, questions, rand)
    
    # Execute
    questions = Array.new
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher1.to_s} execute #{filename}?", true, ['-','-','-','x','-','w','x','r','-','x'], teacher1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher2.to_s} execute #{filename}?", false, ['-','r','w','-','r','-','x','-','w','x'], teacher2, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{student1.to_s} execute #{filename}?", false, ['-','r','w','-','r','w','x','r','w','-'], student2, params)
    filename = "script.sh"
    questions << Question.new(filename, "Can #{teacher2.to_s} execute the shell script #{filename}?", false, ['-','r','w','x','-','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher1.to_s} execute #{filename}?", true, ['-','r','w','x','-','-','x','r','w','x'], teacher1, params)
    part.randomizeQuestions(2, questions, rand)
    
    # Directory Listing
    questions = Array.new
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} list the contents of the directory #{filename} using 'ls'?", true, ['d','r','-','-','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{student2.to_s} list the contents of the directory #{filename} using 'ls'?", false, ['d','-','-','x','r','w','x','-','w','x'], teacher2, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{student1.to_s} list the contents of the directory #{filename} using 'ls -l'?", false, ['d','r','-','-','r','w','x','r','-','x'], student1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher2.to_s} list the contents of the directory #{filename} using 'ls -l'?", true, ['d','r','-','-','r','-','x','r','-','x'], student2, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} list the contents of the directory #{filename} using 'ls -l'?", true, ['d','r','-','-','r','-','x','r','-','x'], parent1, params)
    
    part.randomizeQuestions(2, questions, rand)    
    part.qdb.questions.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    @parts << part
    
    
    # Del 2
    part = Linux.new(rand, "Part 2 - Create / Remove")
    part.dirs << Directory.new(".", ['d','r','w','x','r','w','x','r','w','x'], student1) 
    part.dirs << Directory.new("..", ['d','r','w','x','r','w','x','r','w','x'], teacher1) 
    questions = Array.new
        
    # Create
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{student1.to_s} create a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} create a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} create a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} create a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} create a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    part.randomizeQuestions(2, questions, rand)
        
    # Remove
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} delete a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} delete a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} delete a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} delete a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    filename = namer.getRandomDirectoryName
    questions << Question.new(filename, "Can #{teacher1.to_s} delete a file inside #{filename}?", true, ['d','r','w','x','r','w','x','r','w','x'], teacher1, params)
    part.randomizeQuestions(2, questions, rand)  

    part.qdb.questions.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    @parts << part
        
    
    # Del 3
    part = Linux.new(rand, "Part 3 - Sticky Bits")
    part.dirs << Directory.new(".", ['d','r','w','x','r','w','x','r','w','t'], teacher1) 
    part.dirs << Directory.new("..", ['d','r','w','x','r','w','x','r','w','x'], teacher2)     
    questions = Array.new
    
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher1.to_s} delete #{filename}?", true, ['-','-','-','x','-','-','x','r','-','t'], teacher2, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{student1.to_s} delete #{filename}?", false, ['-','r','-','x','r','-','-','r','-','t'], parent1, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{student2.to_s} delete #{filename}?", true, ['-','r','-','x','-','w','x','r','-','t'], student2, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{parent1.to_s} rename #{filename}?", false, ['-','r','-','x','r','-','x','r','-','t'], teacher2, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher2.to_s} rename #{filename}?", false, ['-','-','-','x','-','w','x','-','-','-'], student2, params)
    filename = namer.getRandomName
    questions << Question.new(filename, "Can #{teacher2.to_s} rename #{filename}?", true, ['-','-','-','x','-','w','x','-','-','-'], student2, params)

    part.randomizeQuestions(2, questions, rand)      
    part.qdb.questions.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    @parts << part


    @total = 0
    @totalCorrect = 0
    @parts.each do |linux|
      @total += linux.qdb.questions.length
      @totalCorrect += linux.qdb.nbrCorrect?
    end    
  end
end
