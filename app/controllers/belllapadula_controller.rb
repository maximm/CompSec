class BelllapadulaController < ApplicationController
  def index
    @bpmatrix = Bpmatrix.new
    @curracc = Bpaccesses.new
  end
end
