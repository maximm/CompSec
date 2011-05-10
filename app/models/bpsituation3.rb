class Bpsituation3
  attr_accessor :bp, :questions, :bpmatrix, :curracc
  def initialize(rand, params)
    @bpmatrix = Bpmatrix.new
    @curracc = Bpaccesses.new
    namer = Filenames.new(rand)
    
    # Subjects
    s = Array.new
    s << BpSubject.new(namer.getRandomUserName, ["B"], Securitylevel.new(1), Securitylevel.new(1))
    s << BpSubject.new(namer.getRandomUserName, ["A", "B"], Securitylevel.new(1), Securitylevel.new(0))
    s << BpSubject.new(namer.getRandomUserName, ["A"], Securitylevel.new(1), Securitylevel.new(1))
    s << BpSubject.new(namer.getRandomUserName, ["A"], Securitylevel.new(1), Securitylevel.new(0))
    s << BpSubject.new(namer.getRandomUserName, ["A", "B"], Securitylevel.new(0), Securitylevel.new(0))
    
    # Objects
    o = Array.new
    o << BpObject.new(namer.getRandomName, ["B"], Securitylevel.new(1))
    o << BpObject.new(namer.getRandomName, ["A", "B"], Securitylevel.new(0))
    o << BpObject.new(namer.getRandomName, ["A", "B"], Securitylevel.new(0))
    o << BpObject.new(namer.getRandomName, ["A"], Securitylevel.new(1))
    o << BpObject.new(namer.getRandomName, ["A"], Securitylevel.new(0))


                                    
    # Accessmatrix & Current accesses
      # Violating ss and *-property
      @bpmatrix.addAccesses(s[0], o[0], ["r"])
      @bpmatrix.addAccesses(s[0], o[1], ["w", "a"])
      @bpmatrix.addAccesses(s[0], o[2], ["w", "a"])
      @bpmatrix.addAccesses(s[0], o[4], ["r"])      
      @curracc.addAccess(Access.new(s[0], o[0], "r"))
      @curracc.addAccess(Access.new(s[0], o[1], "w"))


      # Violates DS and satisfies *-prop
      @bpmatrix.addAccesses(s[1], o[0], ["r", "w"])
      @bpmatrix.addAccesses(s[1], o[1], ["r", "a", "w"])
      @bpmatrix.addAccesses(s[1], o[4], ["w"])
      @bpmatrix.addAccesses(s[1], o[3], ["w"])
      @bpmatrix.addAccesses(s[1], o[1], ["a"])
      @curracc.addAccess(Access.new(s[1], o[1], "r"))
      @curracc.addAccess(Access.new(s[1], o[2], "w"))

      # Violates ss because of classifications
      @bpmatrix.addAccesses(s[2], o[0], ["w", "r"])
      @bpmatrix.addAccesses(s[2], o[1], ["r"])
      @bpmatrix.addAccesses(s[2], o[2], ["w"])
      @curracc.addAccess(Access.new(s[2], o[0], "r"))

      # Violates *-prop because of possible transfer of information to lower access objects
      @bpmatrix.addAccesses(s[3], o[0], ["r", "w"])
      @bpmatrix.addAccesses(s[3], o[1], ["r", "a"])
      @bpmatrix.addAccesses(s[3], o[3], ["r"])
      @bpmatrix.addAccesses(s[3], o[4], ["a", "w"])
      @curracc.addAccess(Access.new(s[3], o[3], "r"))
      @curracc.addAccess(Access.new(s[3], o[4], "a"))


      # Satisfies *-property. Violates ds-property
      @bpmatrix.addAccesses(s[4], o[1], ["r", "w"])
      @bpmatrix.addAccesses(s[4], o[2], ["a"])
      @bpmatrix.addAccesses(s[4], o[3], ["w", "a"])
      @curracc.addAccess(Access.new(s[4], o[1], "w"))
      @curracc.addAccess(Access.new(s[4], o[2], "r"))         
            
   
    # Sort and add
    @curracc.accesses.sort!  { |a,b| a.subject.name.downcase <=> b.subject.name.downcase }
    @bp = Belllapadula.new(@bpmatrix, @curracc)
    s.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    s.each { |subject| @bpmatrix.addSubject(subject) }
    o.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    o.each{ |object| @bpmatrix.addObject(object)}    
    
    # Questions
    @questions = Array.new
    nbrs = namer.getRandomNumbers(3, 5)
    nbrs.each do |nbr|
      subject = @bpmatrix.subjects[nbr]
      @questions << BpQuestionYesNo.new(rand.rand.to_s, "Do all current access operations performed by #{subject} satisfy the ds-property?", @bp.dsPropertyOK(subject).length == 0, params)
      @questions << BpQuestionYesNo.new(rand.rand.to_s, "Do all current access operations performed by #{subject} satisfy the ss-property?", @bp.ssPropertyOK(subject).length == 0, params)
      @questions << BpQuestionYesNo.new(rand.rand.to_s, "Do all current access operations performed by #{subject} satisfy the *-property?", @bp.starPropertyOK(subject).length == 0, params)
    end
    @questions << BpQuestionYesNo.new(rand.rand.to_s, "Is the state considered secure?", @bp.isSecure?, params)
  end
end