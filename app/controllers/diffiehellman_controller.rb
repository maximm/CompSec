class DiffiehellmanController < ApplicationController
  def index
  end
  
  def create
    @username = params[:un]['un']
    modder = Modmath.new
    r = Random.new(@username.hash)
    @primeP = r.rand(100000000000000) * 2**1024
    if @primeP%2 == 0 then
      @primeP += 1
    end
    @generatorG = [2, 5, 11][r.rand(3)]
    
    keyAlice = r.rand(100000000000000) * 2**2048
    keyBob = r.rand(100000000000000) * 2**2048
    
    @keyPartAlice = modder.pow(@generatorG, keyAlice, @primeP)
    @keyPartBob = modder.pow(@generatorG, keyBob, @primeP)
    
    
    begin
      if !params[:key].nil? then
        @suggestedKeyAlice = Integer(params[:key]['alice'])
        @suggestedKeyBob = Integer(params[:key]['bob'])
      end
      
      if !params[:key].nil? && !params[:key]['mimkey'].nil? then
        @mimkey = Integer(params[:key]['mimkey'])
        @correctKeyAlice = @suggestedKeyAlice == modder.pow(@keyPartAlice, @mimkey, @primeP)
        @correctKeyBob = @suggestedKeyBob == modder.pow(@keyPartBob, @mimkey, @primeP)
        
        if @correctKeyAlice && @correctKeyBob then
          render :action => "finished"
        end
      end
    rescue Exception => e    
      @error = "One or more fields were either blank or had an incorrectly formatted number in it"
    end
  end
  
  def finished
  end
  
  def calculator
    modder = Modmath.new
    begin
      @x = Integer(params[:data]['x'])
      @y = Integer(params[:data]['y'])
      @z = Integer(params[:data]['z'])
      @answer = modder.pow(@x, @y, @z)
    rescue
      @error = "Error: One of the fields had an incorrect value"
    end
            
  end
end

class String
  def is_integer?
    self.to_i.to_s == self
  end
end