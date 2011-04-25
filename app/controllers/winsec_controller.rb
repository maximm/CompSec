class WinsecController < ApplicationController
  def index
    
  end
  
  def create
    @username = params[:un]['un']
    @files = Array.new
    @r = Random.new(@username.hash)

    # File 1    
    file = Winfile.new("readme.txt")

    file.dacl << Ace.new("allow", "Everyone", "Full Control")
    file.dacl << Ace.new("deny", "Alice", "Execute")
    file.dacl << Ace.new("deny", "Alice", "Read, Write")
    file.dacl << Ace.new("deny", "Bob", "Read")
    file.dacl << Ace.new("deny", "Bob", "Full Control")
    
    file.questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Execute, Write]?", @r.rand.to_s, true, params)
    file.questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    file.questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Full Control]?", @r.rand.to_s, true, params)

    @files << file    
    
    
    # File 2
    file = Winfile.new("data.exe")

    file.dacl << Ace.new("deny", "Everyone", "Write")
    file.dacl << Ace.new("allow", "Everyone", "Read")
    file.dacl << Ace.new("deny", "Alice", "Read")
    file.dacl << Ace.new("allow", "Alice", "Read")
    file.dacl << Ace.new("deny", "Bob", "Read")
    file.dacl << Ace.new("allow", "Bob", "Write")
    
    file.questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    file.questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, false, params)
    file.questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    file.questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, false, params)

    @files << file
    
    
    # File 3
    file = Winfile.new("report.ppt")

    file.questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Execute, Write]?", @r.rand.to_s, false, params)
    file.questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Write]?", @r.rand.to_s, false, params)

    @files << file    
    
    
    # File 2
    file = Winfile.new("MsPaint.exe")

    file.dacl << Ace.new("deny", "Students", "Execute")
    file.dacl << Ace.new("allow", "Teachers", "Execute")
    file.dacl << Ace.new("deny", "Alice", "Execute")
    file.dacl << Ace.new("deny", "Bob", "Execute")
    file.dacl << Ace.new("allow", "Students", "Read")
    
    file.questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    file.questions << WinQuestion.new("Will Bob (Teachers) be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, true, params)
    file.questions << WinQuestion.new("Will Bob (Teachers) be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    file.questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    file.questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)

    @files << file    


    @correct = 0
    @total = 0
    @files.each do |file|
      file.questions.each do |question|
        @total += 1
        if question.correct == true then
          @correct += 1
        end
      end
    end    


  end
end
