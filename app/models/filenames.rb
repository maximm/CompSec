class Filenames
  attr_accessor :names, :ends, :rand
  def initialize(rand)
    @rand = rand
    @names = ["readme", "database", "compiler", "solutions", "trackingdata", "breadcrumbs", "site", "origin", "training", "backstory", "static", "core", "Bonjour", "bpftp", "fraps", "docu1", "pics", "vacc", "blops", "imgs", "marvell", "IE9", "iTunes", "Windows8", "BBQparty", "Drone", "cakeislie", "draganov", "assassinationplans", "exam20110813", "extrmemakeover", "argasnickaren", "nbr42"]
    @ends = [".txt", ".file", "", ".c", ".java", ".class", ".sql", ".dbz", ".bat", ".exe", ".zip", ".rar", ".sha1"]
  end
  
  def getRandomName
    name = @names[@rand.rand(@names.length)]
    @names = names - [name]
    name = name + @ends[@rand.rand(@ends.length)]
  end
end