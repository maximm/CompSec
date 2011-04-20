class Dacl
  attr_accessor :list
  
  def initialize
    @list = Array.new
    @list << Acl.new
    @list << Acl.new
    @list << Acl.new
  end
end