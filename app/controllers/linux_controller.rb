class LinuxController < ApplicationController
  def index
  end
  
  def create
    @username = params[:un]['un']

    # Brand new user
    r = Random.new
    if Linuxtry.find_by_username(@username).nil? then
      Linuxtry.new(:username => @username, :trynbr => 1, :seed => r.rand(9999999999)).save
    end
    
    # Fetch user from database
    @user = Linuxtry.find_by_username(@username)

    # Check if user has all answers correct
    @correct = false;
    @total = 0
    @totalCorrect = 0
    @questions = Linuxquestions.new(@user, params)
    @questions.parts.each do |linux|
      @total += linux.qdb.questions.length
      @totalCorrect += linux.qdb.nbrCorrect?
    end  
    
    if @totalCorrect == @total
      studentfactory = Studentfactory.new
      studentfactory.approveProject2(@username)
      @correct = true;
    end

    # Check if user has reached its try limit 

    if Linuxtry.find_by_username(@username).trynbr >=5 then
      Linuxtry.find_by_username(@username).destroy
      Linuxtry.new(:username => @username, :trynbr => 0, :seed => r.rand(9999999999)).save
      @user = Linuxtry.find_by_username(@username)
    end
    
    @user.update_attributes(:trynbr => @user.trynbr+1)
    @questions = Linuxquestions.new(@user, params)
  end
end
