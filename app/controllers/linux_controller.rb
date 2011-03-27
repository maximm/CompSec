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
    part.dirs << Directory.new(".", ['d','r','w','x','r','w','x','r','w','t'], "Alice", "Teachers") 
    part.dirs << Directory.new("..", ['d','r','w','x','r','w','x','r','w','t'], "Alice", "Teachers") 
    
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Alice read #{filename}?", true, ['-','r','w','x','r','w','x','r','w','x'], "Alice", "Students", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Bob read #{filename}?", true, ['-','r','w','x','r','w','x','r','w','x'], "Alice", "Students", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Donatello write to #{filename}?", false, ['-','-','-','x','r','w','x','r','w','x'], "Donatello", "Students", part.qdb.isChecked?(filename, params)))
    @parts << part

    # Del 2
    part = Linux.new(rand, "Part 2 - Execute")
    part.dirs << Directory.new(".", ['d','r','w','x','r','w','x','r','w','t'], "Alice", "Teachers") 
    part.dirs << Directory.new("..", ['d','r','w','x','r','w','x','r','w','t'], "Alice", "Teachers")     
    
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Roland delete #{filename}?", true, ['-','r','w','x','r','w','x','r','w','x'], "Bob", "Test", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Jesus move #{filename}?", false, ['-','r','w','x','r','w','x','r','w','x'], "Bob", "Test", part.qdb.isChecked?(filename, params)))
    filename = filenamer.getRandomName
    part.qdb.add(Question.new(filename, "Can Testo delete to #{filename}?", false, ['r','w','-','x','r','w','x','r','w','x'], "Bob", "Test", part.qdb.isChecked?(filename, params)))
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
