class WinsecController < ApplicationController
  def index
    
  end
  
  def create
    @username = params[:un]['un']
    @files = Array.new
    @r = Random.new(@username.hash)
    questions = Array.new
    
    # Users
    

    # File 1 - General knowledge
    file = Winfile.new("readme.xml")
    file.dacl << Ace.new("deny", "Alice", "Execute")
    file.dacl << Ace.new("deny", "Alice", "Write")
    file.dacl << Ace.new("deny", "Bob", "Read")
    file.dacl << Ace.new("deny", "Bob", "Full Control")
    file.dacl << Ace.new("allow", "Everyone", "Full Control")

    questions = Array.new    
    questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Execute, Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Eve be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Eve be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Full Control]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Write]?", @r.rand.to_s, false, params)
    file.randomizeQuestions(3, questions, @r)
    @files << file    
    
    # File 2 - General Knowledge
    file = Winfile.new("data.txt")

    file.dacl << Ace.new("deny", "Everyone", "Write")
    file.dacl << Ace.new("deny", "Alice", "Read")
    file.dacl << Ace.new("deny", "Bob", "Read")
    file.dacl << Ace.new("allow", "Everyone", "Read")
    file.dacl << Ace.new("allow", "Alice", "Read")
    file.dacl << Ace.new("allow", "Bob", "Write")
    
    questions = Array.new
    questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Eve be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Eve be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    file.randomizeQuestions(3, questions, @r)
    @files << file
    
    
    # File 3 - Empty DACL
    file = Winfile.new("report.ppt")
    
    questions = Array.new
    questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Execute, Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Bob be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Alice be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    file.randomizeQuestions(2, questions, @r)
    @files << file    
    
    # File 4 - ACEs containt groups mixed with users
    file = Winfile.new("LoveVirus.exe")

    file.dacl << Ace.new("deny", "Students", "Execute")
    file.dacl << Ace.new("deny", "Alice", "Execute")
    file.dacl << Ace.new("deny", "Bob", "Execute")
    file.dacl << Ace.new("allow", "Teachers", "Execute")
    file.dacl << Ace.new("allow", "Students", "Read")
    file.dacl << Ace.new("allow", "Students", "Write")
    
    questions = Array.new
    questions << WinQuestion.new("Will Bob (Teachers) be allowed to gain the following permissions: [Write, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Bob (Teachers) be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Eve (Teachers) be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Write]?", @r.rand.to_s, true, params)
    file.randomizeQuestions(3, questions, @r)
    @files << file   


    # File 5 - Deny and Allowed mixed including groups
    file = Winfile.new("MsPaint.exe")

    file.dacl << Ace.new("deny", "Students", "Execute")
    file.dacl << Ace.new("allow", "Teachers", "Execute")
    file.dacl << Ace.new("deny", "Alice", "Execute")
    file.dacl << Ace.new("deny", "Bob", "Execute")
    file.dacl << Ace.new("allow", "Students", "Read")
    
    questions = Array.new
    questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Alice (Students) be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Bob (Teachers) be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will Bob (Teachers) be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Eve (Teachers) be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will Eve (Teachers) be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    file.randomizeQuestions(3, questions, @r)
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
