class WinsecController < ApplicationController
  def index
    
  end
  
  def create
    @files = Array.new
    @files << Winfile.new("readme.txt")
  end
end
