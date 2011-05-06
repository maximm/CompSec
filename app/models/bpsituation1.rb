class Bpsituation1
  attr_accessor :bp, :questions
  def initialize(username, params)
    @bpmatrix = Bpmatrix.new
    rand = Random.new(username.hash)
    
    # Subjects
    alice = BpSubject.new("Alice", ["A", "B"], Securitylevel.new(1), Securitylevel.new(0))
    david = BpSubject.new("David", ["B"], Securitylevel.new(1), Securitylevel.new(1))
    erika = BpSubject.new("Erika", ["A", "B"], Securitylevel.new(1), Securitylevel.new(0))
    @bpmatrix.addSubject(alice)
    @bpmatrix.addSubject(david)
    @bpmatrix.addSubject(erika)
    
    # Objects
    file_a = BpObject.new("file_a", ["A", "B"], Securitylevel.new(1))
    file_b = BpObject.new("file_b", ["A", "B"], Securitylevel.new(0))
    file_c = BpObject.new("file_c", ["A", "B"], Securitylevel.new(0))
    @bpmatrix.addObject(file_a)
    @bpmatrix.addObject(file_b)
    @bpmatrix.addObject(file_c)
                                    
    # Accessmatrix
    @bpmatrix.addAccesses(alice, file_a, ["r", "e"])
    @bpmatrix.addAccesses(david, file_b, ["r"])
    @bpmatrix.addAccesses(david, file_b, ["r", "w"])
    @bpmatrix.addAccesses(erika, file_a, ["a", "r"])
    
    # Currect Accesses
    @curracc = Bpaccesses.new
    @curracc.addAccess(Access.new(alice, file_a, "a"))
    @curracc.addAccess(Access.new(alice, file_b, "r"))
    #@curracc.addAccess(Access.new(david, file_b, "w"))
    #@curracc.addAccess(Access.new(erika, file_c, "w"))
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
end