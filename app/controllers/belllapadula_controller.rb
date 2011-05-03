class BelllapadulaController < ApplicationController
  def index
    @bpmatrix = Bpmatrix.new
    @curracc = Bpaccesses.new
    @bp = Belllapadula.new(@bpmatrix, @curracc)
  end
end
