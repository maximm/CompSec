class Bpmatrix
  attr_accessor :subjects, :objects, :matrix
  def initialize
    rand = Random.new("hi".hash)
    #Subjects
    @subjects = Array.new
    @subjects << Bpuser.new("Alice", ["A", "B"], "private", "private")
    @subjects << Bpuser.new("Bob", ["B"], "private", "public")
    
    #Objects
    @objects = Array.new
    @objects << Bpfile.new("file_a", ["A"], "private")
    @objects << Bpfile.new("file_b", ["B"], "public")
    
    # Accessmatris
    rights = ["r", "w", "e", "a", "-"]
    @matrix = Hash.new
    self.addAccesses("Alice", "file_a", ["r", "e"])
    self.addAccesses("Alice", "file_b", ["r"])
    self.addAccesses("Bob", "file_b", ["r", "w"])
    self.addAccesses("Eve", "file_c", ["a", "r"])
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
    @accesses << Access.new("Alice", "file_a", "r")
    @accesses << Access.new("Bob", "file_b", "w")
    @accesses << Access.new("Eve", "file_c", "a")
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

class Bpuser
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

class Bpfile
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
      if @bpmatrix.allowedAccess?(access.subject, access.object, access.action) == false
        notAllowed << access
      end
    end
    return notAllowed
  end  
  
end
