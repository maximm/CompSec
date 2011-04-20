class Winfile
  attr_accessor :dacl, :filename
  
  def initialize(filename)
    @dacl = Array.new
    @dacl << Ace.new(1)
    @dacl << Ace.new(2)
    @dacl << Ace.new(3)
    
    @filename = filename
  end
end