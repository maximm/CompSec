class BelllapadulaController < ApplicationController
  def index
    
  end
  
  def create
    @username = params[:un]['un']    
    studentfactory = Studentfactory.new
    @showproperties = false
    rand = Random.new(@username.hash)

    @bps = Array.new
    @bps << Bpsituation1.new(rand, params)
    @bps << Bpsituation3.new(rand, params)
    
    @total = 0
    @totalCorrect = 0
    @bps.each do |bp|
      @total += bp.questions.length
      bp.questions.each do |question|
        if question.correct then
          @totalCorrect += 1
        end
      end  
    end
    
    if @totalCorrect == @total
      studentfactory.approveProject5(@username)
    end
  end
end