class LinuxController < ApplicationController
  def index
    #@linux = Linux.new(params)
  end
  
  def create
    rand = Random.new("username".hash)
    filenamer = Filenames.new(rand)
    @parts = Array.new
    
    # Del 1
    part = Linux.new(rand, "Part 1 - Read / Write")
    part.dirs << Directory.new(".", ['d','r','w','x','r','w','x','r','w','-'], "Bobby", "Teachers") 
    part.dirs << Directory.new("..", ['d','r','w','x','r','w','x','r','w','x'], "Bobby", "Teachers") 
    
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Alice (Students) read #{filename}?", true, ['-','r','w','x','r','w','x','r','-','-'], "Bobby", "Teachers", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Alice (Students) read #{filename}?", false, ['-','-','w','x','-','w','x','r','w','x'], "Bobby", "Teachers", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Alice (Students) read #{filename}?", true, ['-','-','w','x','r','-','-','-','w','-'], "Mindy", "Students", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Bobby (Teachers) read #{filename}?", false, ['-','-','w','x','r','w','x','r','w','x'], "Bobby", "Teachers", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Bobby (Teachers) write to #{filename}?", true, ['-','r','w','x','-','w','-','r','w','x'], "Bobby", "Teachers", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Mindy (Teachers) write to #{filename}?", false, ['-','r','-','x','r','-','x','r','w','x'], "Bobby", "Teachers", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can John (Parents) write to #{filename}?", false, ['-','r','w','-','-','-','-','r','w','x'], "Bobby", "Teachers", part.qdb.isChecked?(filename, params)))

    
    @parts << part

    # Del 2
    part = Linux.new(rand, "Part 2 - Execute")
    part.dirs << Directory.new(".", ['d','r','w','-','r','w','x','r','w','x'], "Alice", "Students") 
    part.dirs << Directory.new("..", ['d','r','w','x','r','w','x','r','w','-'], "Bobby", "Teachers")     
    
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Alice (Students) execute #{filename}?", false, ['-','r','w','-','r','w','x','r','w','x'], "Alice", "Students", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Alice (Students) execute #{filename}?", false, ['-','r','w','x','r','w','-','r','w','x'], "Alice", "Students", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Alice (Students) execute #{filename}?", false, ['r','w','-','x','r','w','x','r','w','-'], "Alice", "Students", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Bobby (Teachers) execute #{filename}?", true, ['r','w','-','x','r','w','x','r','w','x'], "Alice", "Students", part.qdb.isChecked?(filename, params)))
    filename = "script.sh"
    part.qdb.add(Question.new(filename, "Can Bobby (Teachers) execute #{filename}?", true, ['r','w','-','x','r','w','x','r','w','x'], "Alice", "Students", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can John (Parents) execute #{filename}?", false, ['r','w','-','x','r','w','x','r','w','x'], "Alice", "Students", part.qdb.isChecked?(filename, params)))

    @parts << part    


    # Del 3
    part = Linux.new(rand, "Part 3 - Move / Remove / Create")
    @parts << part
    
    # Del 4
    part = Linux.new(rand, "Part 4 - Access")
    @parts << part
    
    # Del 5
    part = Linux.new(rand, "Part 5 - Sticky Bits")
    @parts << part

    # Del 6
    part = Linux.new(rand, "Part 6 - Listing Directories")
    @parts << part

    @total = 0
    @totalCorrect = 0
    @parts.each do |linux|
      @total += linux.qdb.questions.length
      @totalCorrect += linux.qdb.nbrCorrect?
    end    
    
  end
end
