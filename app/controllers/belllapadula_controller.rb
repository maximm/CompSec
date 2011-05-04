class BelllapadulaController < ApplicationController
  def index
    @bpmatrix = Bpmatrix.new
    
    
    
    # Subjects
    alice = BpSubject.new("Alice", ["A", "B"], Securitylevel.new(0), Securitylevel.new(1))
    bob = BpSubject.new("Bob", ["B"], Securitylevel.new(1), Securitylevel.new(1))
    eve = BpSubject.new("Eve", ["A", "B"], Securitylevel.new(1), Securitylevel.new(0))
    @bpmatrix.addSubject(alice)
    @bpmatrix.addSubject(bob)
    @bpmatrix.addSubject(eve)
    
    # Objects
    file_a = BpObject.new("file_a", ["A", "B"], Securitylevel.new(0))
    file_b = BpObject.new("file_b", ["B"], Securitylevel.new(1))
    file_c = BpObject.new("file_c", ["A", "B"], Securitylevel.new(0))
    @bpmatrix.addObject(file_a)
    @bpmatrix.addObject(file_b)
    @bpmatrix.addObject(file_c)
                                    
    # Accessmatrix
    @bpmatrix.addAccesses(alice, file_a, ["r", "e"])
    @bpmatrix.addAccesses(bob, file_b, ["r"])
    @bpmatrix.addAccesses(bob, file_b, ["r", "w"])
    @bpmatrix.addAccesses(eve, file_a, ["a", "r"])
    
    # Currect Accesses
    @curracc = Bpaccesses.new
    @curracc.addAccess(Access.new(alice, file_a, "r"))
    @curracc.addAccess(Access.new(bob, file_b, "w"))
    @curracc.addAccess(Access.new(eve, file_c, "w"))
    
    @bp = Belllapadula.new(@bpmatrix, @curracc)
  end
end
