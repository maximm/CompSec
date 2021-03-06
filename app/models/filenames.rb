class Filenames
  attr_accessor :names, :ends, :rand
  def initialize(rand)
    @rand = rand
    @names = ["readme", "database", "compiler", "solutions", "trackingdata", "breadcrumbs", "site", "origin", "training", "backstory", "static", "core", "Bonjour", "bpftp", "fraps", "docu1", "pics", "vacc", "blops", "imgs", "marvel", "IE9", "iTunes", "Windows8", "BBQparty", "Drone", "cakeislie", "draganov", "assassinationplans", "exam20110813", "extrmemakeover", "argasnickaren", "nbr42"]
    @ends = [".txt", ".file", "", ".c", ".java", ".class", ".sql", ".dbz", ".bat", ".exe", ".zip", ".rar", ".sha1"]
    @usernames = ["Alice", "Bob", "Sarah", "Mindy", "John", "Shannon", "Tracy", "Jordan", "Urkel", "Stephen", "Anders", "Erik", "Morgan", "Daniel", "Danielle", "Billy", "Terrence", "Magoo", "Poolo", "Mr. B", "Ballsy"]
    @directorynames = ["Photos", "Java", "Personal Documents", "Economy Calculator", "Pictures", "Videos", "Personal Files", "Extreme Stuff", "Where is Waldo", "Dummy Objects", "Adobe", "Microsoft", "Hangover Memories", "Dreaming Meerkats", "Silly Cats", "Reddit.com Saves", "Crysis 2", "Half Life 2", "Portal 2", "Nintendo 3DS", "Holy Grails", "Angry Nintendo Nerd", "Bring Sexy Back", "This is Bat Country"]
    @groupnames = ["Students", "Teachers", "Admins", "Faculty", "Trainees", "Dreamers", "TeamOne", "TeamTwo", "MyClass", "Users", "Networkers", "Pitchers", "Greasers"]
  end
  
  def getRandomName
    name = @names[@rand.rand(@names.length)]
    @names = names - [name]
    name = name + @ends[@rand.rand(@ends.length)]
  end
  
  def getRandomUserNameWithGroup(group)
    name = @usernames[@rand.rand(@usernames.length)]
    @usernames = @usernames - [name]
    return Queryuser.new(name, group)    
  end
  
  def getRandomUserName
    name = @usernames[@rand.rand(@usernames.length)]
    @usernames = @usernames - [name]
    return name  
  end  
  
  def getRandomGroupName
    name = @groupnames[@rand.rand(@groupnames.length)]
    @groupnames = @groupnames - [name]
    
    return [name]  
  end    
  
  def getRandomDirectoryName
    name = @directorynames[@rand.rand(@directorynames.length)]
    @directorynames = @directorynames - [name]
    return name
  end
  
  def getRandomNumbers(amount, maxNbr)
    takeNbrs = Array.new
    nbrs = Array.new(maxNbr) {|x| x+1}
    amount.times do
      nbr = nbrs[@rand.rand(nbrs.length)]
      nbrs = nbrs - [nbr]      
      takeNbrs << nbr
    end
    return takeNbrs
  end
end