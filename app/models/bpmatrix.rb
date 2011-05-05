class Bpmatrix
  attr_accessor :subjects, :objects, :matrix
  def initialize
    @subjects = Array.new
    @objects = Array.new
    @matrix = Hash.new    
  end
  
  def addSubject(subject)
    @subjects << subject
  end
  
  def addObject(object)
    @objects << object
  end


  def addAccesses(subject, object, accesses)
    @matrix["#{subject}#{object}"] = accesses
  end
  
  def allowedAccesses(subject, object)
    accesses = @matrix["#{subject}#{object}"]
    if accesses.nil? then
      return "-"
    else 
      return accesses.join(", ") 
    end
  end
  
  def allowedAccess?(subject, object, access)
    accesses = @matrix["#{subject}#{object}"]
    if accesses.nil? then
      return false
    elsif accesses.index(access).nil?
      return false
    else 
      return true 
    end
  end
  
  def fs
    fs = ""
    @subjects.each {|s| fs << "#{s}: (#{s.seclev}, {#{s.classifications.join(",")}}), "}
    return fs.rstrip.chop
  end
  
  def fc
    fc = ""
    @subjects.each {|s| fc << "#{s}: (#{s.seclevcurr}, {#{s.classifications.join(",")}}), "}
    return fc.rstrip.chop
  end
  
  def fo
    fo = ""
    @objects.each {|s| fo << "#{s}: (#{s.seclev}, {#{s.classifications.join(",")}}), "}
    return fo.rstrip.chop
  end
end

class Bpaccesses
  attr_accessor :accesses
  def initialize
    @accesses = Array.new
  end
  
  def addAccess(access)
    @accesses << access
  end
end

class Access
  attr_accessor :subject, :object, :action
  def initialize(subject, object, action)
    @subject = subject
    @object = object
    @action = action
  end
end

class BpSubject
  attr_accessor :name, :classifications, :seclev, :seclevcurr

  def initialize(name, classifications, seclev, seclevcurr)
    @name = name
    @classifications = classifications
    @seclev = seclev
    @seclevcurr = seclevcurr
  end
  
  def to_s
    @name
  end
end

class BpObject
  attr_accessor :name, :classifications, :seclev
  
  def initialize(name, classifications, seclev)
    @name = name
    @classifications = classifications
    @seclev = seclev
  end
  
  def to_s
    @name
  end
end

class Securitylevel
  attr_accessor :level
  def initialize(level)
    @level = level
  end
  
  def to_s
    if level == 0 then
      return "public"
    elsif level == 1 then
      return "private"
    else
      return "???"
    end
  end
end

class Belllapadula
  attr_accessor :bpmatrix, :bpaccesses
  def initialize(bpmatrix, bpaccesses)
    @bpmatrix = bpmatrix
    @bpaccesses = bpaccesses
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
      access.subject.classifications.each do |classification|
        if access.object.classifications.include?(classification) then
          appendNbr += 1
        end
      end
      appendOK = appendNbr == access.subject.classifications
      
      if access.action == "a" && access.object.seclev.level < access.subject.seclevcurr.level && !appendOK && !added
        notAllowed << access
        added = true
      elsif access.action == "w" && access.subject.classifications != access.object.classifications && !added 
        notAllowed << access
        added = true
      end
    end
    return notAllowed
  end  
  
  def starPropertySimpleOK?
    notAllowed = Array.new
    @bpaccesses.accesses.each do |access|
      appendNbr = 0
      access.subject.classifications.each do |classification|
        if access.object.classifications.include?(classification) then
          appendNbr += 1
        end
      end
      appendOK = appendNbr == access.subject.classifications.length
      
      if access.action == "a" && (access.object.seclev.level < access.subject.seclevcurr.level || !appendOK)
        notAllowed << access
      elsif access.action == "w" && access.subject.classifications != access.object.classifications 
        notAllowed << access
      end
    end
    return notAllowed
  end

  # ds-property
  def ds(access)
    return !self.dsPropertyOK?.include?(access) 
  end
  
  # ss-property
  def ss(access)
    return !self.ssPropertyOK?.include?(access) 
  end
  
  # Complete *-property
  def cs(access)
    return !self.starPropertyOK?.include?(access) 
  end    
  
  # Incomplete *-property
  def is(access)
    return !self.starPropertySimpleOK?.include?(access) 
  end
  
  def isSecure?
    return self.starPropertyOK?.length == 0 && self.ssPropertyOK?.length == 0 && self.dsPropertyOK?.length == 0
  end   
end

class BpQuestion
  attr_accessor :access, :question, :alternatives, :answers
  def initialize(access, question, alternatives, answers)
    @access = access
    @question = question
    @alternatives = alternatives
    @answers = answers
  end
  
  def checkAnswer(answers)
    return @answers == answers
  end
end