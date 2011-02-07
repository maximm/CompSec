class StudentController < ApplicationController
  def index

  end
  
  def create
    # Create the array with 499 student results
    @db = Array.new()
    if !params[:un].nil? then 
      @username = params[:un]['un']
    else
      @username = params[:un2]
    end
    r = Random.new(@username.hash)
    499.times { @db << Student.new(r) }
    
    # Unique property
    s = Student.new(r)
    s.age = 40 + r.rand(10)
    s.sex = "Male"
    @db << s
    
    # Masters
    if !params[:s].nil? && !params[:s]['masters'].empty?
      if Integer(params[:mi]['1']) == 1 then
        @db.delete_if { |s| s.masters == params[:s]['masters'] }
      else
        @db.delete_if { |s| s.masters != params[:s]['masters'] }
      end 
    end
    
    # Age
    if !params[:s].nil? && params[:s]['age'].is_integer? then
      if Integer(params[:ai]['1']) == 1  then
        @db.delete_if { |s| s.age == Integer(params[:s]['age']) }  
      else
        @db.delete_if { |s| s.age != Integer(params[:s]['age']) }
      end
    end
    
    # Sex
    if !params[:s].nil? && params[:gender] == "male" then
      @db.delete_if { |s| s.sex == "Female" }
    elsif !params[:s].nil? && params[:gender] == "female" then
      @db.delete_if { |s| s.sex == "Male" }
    end
    
    if @db.size > 0 then
      @mean = @db.sum { |s| s.score } / Float(@db.size)
    end
        
    # Sort by score
    @db.sort! { |a,b| a.score <=> b.score }
    
    # Submitting results
    @notice = ""
    if !params[:rs].nil? && params[:rs]['rs'].is_integer? then
      if Integer(params[:rs]['rs']) >= s.score - 1 &&  Integer(params[:rs]['rs']) <= s.score + 1 then
        @notice = "<font color='green' size='5'>Congratulations, your result is correct!</font><br>Results have been saved"
      else
        @notice = "<font color='red' size='5'>Answer not correct. Please try again</font>"
      end
    end       
  end
end


class String
  def is_integer?
    self.to_i.to_s == self
  end
end
