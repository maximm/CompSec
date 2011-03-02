class Linux
  attr_accessor :files, :dirs
  
  def initialize()
    r = Random.new("username".hash)
    names = ["readme", "database", "compiler", "solutions", "trackingdata", "breadcrumbs", "site", "origin", "training", "backstory"]
    ends = [".txt", ".file", "", ".c", ".java", ".class", ".sql"]
    @files = Array.new
    @dirs = Array.new
    currdir =  Linuxdirectory.new(".")
    predir = Linuxdirectory.new("..")
    @dirs << predir << currdir
    
    for i in 1..names.length
      name = names[r.rand(names.length)]
      names = names - [name]
      @files << Linuxfile.new(name + ends[r.rand(ends.length)], currdir, predir)
    end
  end
  
    
  def ls_possible?
    @dirs[0].attr[1] == 'r' && @dirs[1].attr[1] == 'r'
  end
  
  def enter_directory_possible?
    @dirs[0].attr[1] == 'r' && @dirs[1].attr[1] == 'r' && @dirs[0].attr[3] == 'x' && @dirs[1].attr[3] == 'x'
  end
  
end

class Linuxdirectory
  attr_accessor :attr, :name
  def initialize(name)
    @attr = ['d','r','w','x','r','w','x','r','w','t']
    @name = name
  end

end

class Linuxfile
  attr_accessor :attr, :name, :currdir, :predir
  def initialize(name, currdir, predir)
    @attr = ['-','r','w','x','r','w','x','r','w','x']
    @name = name
    @currdir = currdir
    @predir = predir
  end
  
  def is_readable?
    self.enter_directory_possible? && @attr[1] == 'r' 
  end
  
  def is_removable?
    @predir.attr[1] == 'r' && @currdir.attr[2] == 'w' && self.enter_directory_possible?
  end
  
  def is_creatable?
    self.is_removable?
  end
  
  def is_changeable?
    self.enter_directory_possible? && attr[1] == 'r' && attr[2] == 'w' 
  end
  
  def is_executable?
    self.enter_directory_possible? && attr[3] == 'x'
  end
  
  def is_shell_executable?
    self.is_executable? && attr[1] == 'r'
  end
  
  def enter_directory_possible?
    @predir.attr[3] == 'x' && @currdir.attr[3] == 'x'
  end
end