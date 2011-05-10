class Belllapadula
  attr_accessor :bpmatrix, :bpaccesses
  def initialize(bpmatrix, bpaccesses)
    @bpmatrix = bpmatrix
    @bpaccesses = bpaccesses
  end

  def dsPropertyOK(subject)
    accesses = self.dsPropertyOK?
    notAllowed = Array.new
    accesses.each do |access|
      if access.subject == subject then
        notAllowed << access
      end
    end
    return notAllowed
  end
  
  def dsPropertyOK?
    notAllowed = Array.new
    @bpaccesses.accesses.each do |access|
      if @bpmatrix.allowedAccess?(access.subject, access.object, access.action) == false
        notAllowed << access
      end
    end
    return notAllowed
  end

  def ssPropertyOK(subject)
    accesses = self.ssPropertyOK?
    notAllowed = Array.new
    accesses.each do |access|
      if access.subject == subject then
        notAllowed << access
      end
    end
    return notAllowed
  end
  
  def ssPropertyOK?
    notAllowed = Array.new
    @bpaccesses.accesses.each do |access|
      clok = true
      access.object.classifications.each do |classification|
        if !access.subject.classifications.include?(classification) then
          clok = false
        end
      end
      if (access.action == "r" || access.action == "w") && (access.object.seclev.level > access.subject.seclev.level || !clok)
        notAllowed << access
      end
    end
    return notAllowed
  end
  
  def starPropertyOK(subject)
    accesses = self.starPropertyOK?
    notAllowed = Array.new
    accesses.each do |access|
      if access.subject == subject then
        notAllowed << access
      end
    end
    return notAllowed
  end
  
  def starPropertyOK?
    notAllowed = Array.new
    @bpaccesses.accesses.each do |access|
      added = false
            
      # Check for other accessess
      otherAccesses = Array.new
      @bpaccesses.accesses.each do |accessOther|
        if access.subject.name == accessOther.subject.name && accessOther != access then
          otherAccesses << accessOther
        end
      end
      
      # Subject has more than one access
      if otherAccesses.length > 0 && (access.action == "r" || access.action == "w") then
        otherAccesses.each do |accessOther|
          if (accessOther.action == "w" || accessOther.action == "a") && access.object.seclev.level > accessOther.object.seclev.level && !added then
            notAllowed << access
            added = true
          end 
        end
      end
      
      appendNbr = 0
      access.object.classifications.each do |classification|
        if access.subject.classifications.include?(classification) then
          appendNbr += 1
        end
      end
      appendOK = appendNbr == access.subject.classifications.length
      
      if access.action == "a" && !appendOK then
        notAllowed << access
      elsif access.action == "a" && access.object.seclev.level < access.subject.seclevcurr.level
        notAllowed << access
      elsif access.action == "w" && (access.subject.classifications != access.object.classifications || access.object.seclev.level < access.subject.seclevcurr.level) 
        notAllowed << access
      end
    end
    return notAllowed
  end  

  # ds-property
  def dsOK?(access)
    return !self.dsPropertyOK?.include?(access) 
  end
  
  # ss-property
  def ssOK?(access)
    return !self.ssPropertyOK?.include?(access) 
  end
  
  # Complete *-property
  def csOK?(access)
    return !self.starPropertyOK?.include?(access) 
  end    
  
  # Incomplete *-property
  def isOK?(access)
    return !self.starPropertySimpleOK?.include?(access) 
  end
  
  def isSecure?
    return self.starPropertyOK?.length == 0 && self.ssPropertyOK?.length == 0 && self.dsPropertyOK?.length == 0
  end   
end