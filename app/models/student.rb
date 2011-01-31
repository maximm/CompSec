class Student
  attr_accessor :masters, :age, :sex, :score
  
  def initialize(r)
    @masters = ["D", "M", "Pi", "I", "C"][r.rand(5)]
    @age = (18 + r.rand(10))
    @sex = ["Male", "Female"][r.rand(2)]
    @score = r.rand(1000)
  end
  
  def to_s
    @masters + " - " + @age.to_s + " - " + @sex + " - " + score.to_s
  end
end