class Ace
  attr_accessor :type, :name, :permission
  
  def initialize(type, name, permission)
    @type = type
    @name = name
    @permission = permission
  end 
end