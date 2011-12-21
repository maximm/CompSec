class WinsecController < ApplicationController
  def index
    
  end
  
  def create
    @username = params[:un]['un']
    @questions = Winsecproject.new(@username, params)
    @files = @questions.files
    
    @correct = 0
    @total = 0
    @files.each do |file|
      file.questions.each do |question|
        @total += 1
        if question.correct == true then
          @correct += 1
        end
      end
    end
    
    if @correct == @total
      studentfactory.approveProject4(@username)
    end    
  end
end
