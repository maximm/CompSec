class BelllapadulaController < ApplicationController
  def index
    @bpmatrix = Bpmatrix.new
    
    
    
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
    @curracc.accesses.each do |access|
      @questions << BpQuestion.new(access, "Does this access violate any of the following properties?", ["ds-property", "ss-property", "incomplete *-property", "*-property"], [@bp.ds(access), @bp.ss(access), @bp.is(access), @bp.cs(access)] )
    end
  end
end