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
  
  def getRandomAccess(rand)
    return @accesses[rand.rand(@accesses.length)]
  end
end

class Access
  attr_accessor :subject, :object, :action
  def initialize(subject, object, action)
    @subject = subject
    @object = object
    @action = action
  end
  
  def to_s
    return "(#{subject}, #{object}, #{action})"
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

class BpQuestionYesNo
  attr_accessor :name, :question, :answer, :checked, :correct
  def initialize(name, question, answer, params)
    @name = name
    @question = question
    @answer = answer
    @checked = self.isChecked?(name, params) 
    @correct = @checked == answer
  end
  
  def isChecked?(name, params)
    if params[name].nil? then
      return ""
    else
      return params[name][name] == 'true'
    end
  end 
end