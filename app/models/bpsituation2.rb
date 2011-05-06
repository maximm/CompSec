class Bpsituation2
  attr_accessor :bp, :questions, :rand
  def initialize(username, params)
    @bpmatrix = Bpmatrix.new
    @rand = Random.new(username.hash)
    namer = Filenames.new(@rand)
    
    # Subjects
    nbrSubjects = 3 + rand.rand(4)
    nbrSubjects.times do 
      @bpmatrix.addSubject(BpSubject.new(namer.getRandomUserName, self.randClass, self.randLevel, self.randLevel))
    end
    
    # Objects
    nbrObjects = 3 + rand.rand(4)
    nbrObjects.times do
      @bpmatrix.addObject(BpObject.new(namer.getRandomName, self.randClass, self.randLevel))
    end    
                                    
    # Accessmatrix
    @bpmatrix.subjects.each do |s|
      @bpmatrix.objects.each do |o|
        actions = self.randActions
        if actions.length > 0 then
          @bpmatrix.addAccesses(s, o, actions)
        end
      end
    end
    
    # Currect Accesses
    @curracc = Bpaccesses.new
    @bpmatrix.subjects.each do |s|
      @bpmatrix.objects.each do |o|
        coin = rand.rand(5)
        if coin == 0 then
          @curracc.addAccess(Access.new(s, o, self.randAction))
        end
      end
    end    
    
    @bp = Belllapadula.new(@bpmatrix, @curracc)
    
    # Questions
    @questions = Array.new
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Is the state considered secure?", @bp.isSecure?, params)
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Does the state conform to the ds-property?", @bp.dsPropertyOK?.length == 0, params)
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Does the state conform to the ss-property?", @bp.ssPropertyOK?.length == 0, params)
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Does the state conform to the incomplete *-property?", @bp.starPropertySimpleOK?.length == 0, params)
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Does the state conform to the *-property?", @bp.starPropertyOK?.length == 0, params)
    
    access = @curracc.getRandomAccess(rand)
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Does the access #{access} conform to the ds-property?", @bp.dsOK?(access), params)
    access = @curracc.getRandomAccess(rand)
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Does the access #{access} conform to the ss-property?", @bp.ssOK?(access), params)
    access = @curracc.getRandomAccess(rand)
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Does the access #{access} conform to the incomplete *-property?", @bp.isOK?(access), params)
    access = @curracc.getRandomAccess(rand)
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Does the access #{access} conform to the *-property?", @bp.csOK?(access), params)
  end
  
  def randLevel
    level = rand.rand(2)
    return Securitylevel.new(level)
  end
  
  def randClass
    classifications = [["A"], ["B"], ["A", "B"]]
    return classifications[rand.rand(classifications.length)]
  end

  def randAction
    actions = ["a", "r", "w", "e"]
    return actions[rand.rand(actions.length)]
  end
  
  def randActions
    actions = ["a", "r", "w", "e"]
    nbr = rand.rand(actions.length)
    myactions = Array.new
    nbr.times do 
      action = actions[rand.rand(actions.length)]
      actions = actions - [action]
      myactions << action
    end
    return myactions
  end
end