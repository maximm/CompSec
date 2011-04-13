class DiffiehellmanController < ApplicationController
  def index
 end
  
  def create
    @username = params[:un]['un']
    modder = Modmath.new
    r = Random.new(@username.hash)
    @primeP = r.rand(100000000000000) * 2**1024
    @generatorG = [2, 5, 11][r.rand(3)]
    
    @keyAlice = r.rand(100000000000000) * 2**2048
    @keyBob = r.rand(100000000000000) * 2**2048
    
    @keyPartAlice = modder.pow(@generatorG, @keyAlice, @primeP)
    @keyPartBob = modder.pow(@generatorG, @keyBob, @primeP)
  end
end
