class Bpmatrix
  attr_accessor :subjects, :objects, :matrix
  def initialize
    #Subjects
    @subjects = Array.new
    @subjects << "Alice" << "Bob" << "Eve"
    #Objects
    @objects = Array.new
    @objects << "file_a" << "file_b" << "file_c"
    
    #Accessmatrix
    @matrix = Array.new

    @subjects.each do |subject|
      subjectrights = Array.new
      @objects.each do |object|
        subjectrights << "read, write"
      end
      @matrix << subjectrights      
    end
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

class Functions
  attr_accessor :fs, :fc, :fo
  def initialize
    
  end
end

class Function
  attr_accessor :
end