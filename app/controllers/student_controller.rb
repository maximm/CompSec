class StudentController < ApplicationController
  def index

  end
  
  def create
     @db = Array.new()
    r = Random.new(params[:un]['un'].hash)
    499.times { @db << Student.new(r) }
    
    # Unique property
    s = Student.new(r)
    s.age = 47
    @db << s
    
    # Sort by score
    @db.sort! { |a,b| a.score <=> b.score }   
  end
end
