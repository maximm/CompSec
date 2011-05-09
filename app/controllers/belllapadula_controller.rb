class BelllapadulaController < ApplicationController
  def index
    
  end
  
  def create
    @username = params[:un]['un']    
    @showproperties = true
    @bp = Bpsituation3.new(Random.new(@username.hash), params)
    @questions = @bp.questions
    
    @bpmatrix = @bp.bp.bpmatrix
    @curracc = @bp.bp.bpaccesses
    @total = @questions.length
    @totalCorrect = 0
    @questions.each do |question|
      if question.correct then
        @totalCorrect += 1
      end
    end  
  end
end