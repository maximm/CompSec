class Queryuser
  attr_accessor :n, :g
  def initialize(name, group)
    @n = name
    @g = group
  end
  
  def to_s
    return "#{@n} (#{@g})"
  end
end