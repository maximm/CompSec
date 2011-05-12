class WinsecController < ApplicationController
  def index
    
  end
  
  def create
    @username = params[:un]['un']
    @files = Array.new
    @r = Random.new(@username.hash)
    questions = Array.new
    namer = Filenames.new(@r)
    
    # File 1 - General knowledge
    file = Winfile.new(namer.getRandomName)

    # Users File 1
    file.tokens << token1 = Wintoken.new(namer.getRandomUserName, [""])
    file.tokens << token2 = Wintoken.new(namer.getRandomUserName, [""])
    file.tokens << token3 = Wintoken.new(namer.getRandomUserName, [""])

    file.dacl << Ace.new("deny", token1, "Execute")
    file.dacl << Ace.new("deny", token1, "Write")
    file.dacl << Ace.new("deny", token2, "Read")
    file.dacl << Ace.new("deny", token2, "Full Control")
    file.dacl << Ace.new("allow", "Everyone", "Full Control")

    questions = Array.new    
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Execute, Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Full Control]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token3} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token3} be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, true, params)
    file.randomizeQuestions(3, questions, @r)
    @files << file    


    
    # File 2 - The Everyone principle continued
    file = Winfile.new(namer.getRandomName)
    
    # Users File 2
    file.tokens << token1 = Wintoken.new(namer.getRandomUserName, [""])
    file.tokens << token2 = Wintoken.new(namer.getRandomUserName, [""])
    file.tokens << token3 = Wintoken.new(namer.getRandomUserName, [""])
    
    file.dacl << Ace.new("deny", "Everyone", "Write")
    file.dacl << Ace.new("deny", token1, "Read")
    file.dacl << Ace.new("deny", token2, "Read")
    file.dacl << Ace.new("allow", "Everyone", "Read")
    file.dacl << Ace.new("allow", token1, "Read")
    file.dacl << Ace.new("allow", token1, "Write")
    
    questions = Array.new
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token3} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token3} be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    file.randomizeQuestions(3, questions, @r)
    @files << file


    # File 3 - Empty DACL
    file = Winfile.new(namer.getRandomName)
    
    # Users File 3
    file.tokens << token1 = Wintoken.new(namer.getRandomUserName, [""])
    file.tokens << token2 = Wintoken.new(namer.getRandomUserName, [""])
        
    questions = Array.new
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Execute, Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Write]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    file.randomizeQuestions(2, questions, @r)
    @files << file    

    # File 4 - Deny and Allowed mixed including groups
    file = Winfile.new(namer.getRandomName)

    # Users File 4
    file.tokens << token1 = Wintoken.new(namer.getRandomUserName, namer.getRandomGroupName)
    group = namer.getRandomGroupName
    file.tokens << token2 = Wintoken.new(namer.getRandomUserName, group)
    file.tokens << token3 = Wintoken.new(namer.getRandomUserName, group)

    file.dacl << Ace.new("deny", token1.groups.join, "Execute")
    file.dacl << Ace.new("allow", token2.groups.join, "Execute")
    file.dacl << Ace.new("deny", token1, "Execute")
    file.dacl << Ace.new("deny", token2, "Execute")
    file.dacl << Ace.new("allow", token1.groups.join, "Read")
    
    questions = Array.new
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token3} be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token3} be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    file.randomizeQuestions(3, questions, @r)
    @files << file 
    
    
    # File 5 - Users with multiple groups
    file = Winfile.new(namer.getRandomName)
    
    # Users File 4
    group1 = namer.getRandomGroupName
    group2 = namer.getRandomGroupName
    group3 = namer.getRandomGroupName
    group4 = namer.getRandomGroupName
    group5 = namer.getRandomGroupName
    group6 = namer.getRandomGroupName
    
    file.tokens << token1 = Wintoken.new(namer.getRandomUserName, group1 + group2)
    file.tokens << token2 = Wintoken.new(namer.getRandomUserName, group1 + group3)
    file.tokens << token3 = Wintoken.new(namer.getRandomUserName, group4 + group5 + group6)

    file.dacl << Ace.new("deny", group4.join, "Execute")
    file.dacl << Ace.new("deny", token3, "Execute")
    file.dacl << Ace.new("deny", token1, "Execute")
    file.dacl << Ace.new("deny", group5.join, "Read")    
    file.dacl << Ace.new("allow", group2.join, "Full Control")
    file.dacl << Ace.new("allow", group1.join, "Execute")
    file.dacl << Ace.new("allow", group4.join, "Read")
    file.dacl << Ace.new("allow", group4.join, "Write")
    file.dacl << Ace.new("allow", group6.join, "Read")
    file.dacl << Ace.new("allow", group3.join, "Execute")
        
    questions = Array.new
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Write, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token1} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token2} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token3} be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token3} be allowed to gain the following permissions: [Write]?", @r.rand.to_s, true, params)
    file.randomizeQuestions(3, questions, @r)
    @files << file
    
    # File 6 - Restricted SIDs
    file = Winfile.new(namer.getRandomName)

    file.tokens << token1 = Wintoken.new(namer.getRandomUserName, group1)
    token1.restrictedsid = group2.join
    file.tokens << token2 = Wintoken.new(namer.getRandomUserName, group1)
    token2.restrictedsid = group3.join
    file.tokens << token3 = Wintoken.new(namer.getRandomUserName, group4 + group5)
    token3.restrictedsid = group6.join
    
    file.dacl << Ace.new("deny", token1, "Write")
    file.dacl << Ace.new("deny", group5.join, "Read")    
    file.dacl << Ace.new("allow", group2.join, "Full Control")
    file.dacl << Ace.new("allow", group1.join, "Execute")
    file.dacl << Ace.new("allow", group1.join, "Read")
    file.dacl << Ace.new("allow", group6.join, "Execute")
    file.dacl << Ace.new("allow", group3.join, "Execute")
        
    questions = Array.new
    questions << WinQuestion.new("Will #{token1} (Teachers, restricted SID Admins) be allowed to gain the following permissions: [Read, Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token1} (Teachers, restricted SID Admins) be allowed to gain the following permissions: [Read]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token2} (Teachers, restricted SID Services) be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, true, params)
    questions << WinQuestion.new("Will #{token2} (Teachers, restricted SID Services) be allowed to gain the following permissions: [Read]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token3} (Students, Faculty, restricted SID Trainees) be allowed to gain the following permissions: [Execute]?", @r.rand.to_s, false, params)
    questions << WinQuestion.new("Will #{token3} (Students, Faculty, restricted SID Trainees) be allowed to gain the following permissions: [Read, Write]?", @r.rand.to_s, false, params)
    file.randomizeQuestions(3, questions, @r)
    @files << file    

    @files.sort! { |a,b| a.filename.downcase <=> b.filename.downcase }
    
    # From 6 to 4 files in project
    @files.delete_at(1)
    @files.delete_at(2)

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
