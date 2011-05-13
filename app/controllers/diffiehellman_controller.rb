class DiffiehellmanController < ApplicationController
  def index
  end
  
  def create
    @username = params[:un]['un']
    studentfactory = Studentfactory.new
    modder = Modmath.new
    r = Random.new(@username.hash)
    @primeP = 179769313486231590770839156793787453197860296048756011706444423684197180216158519368947833795864925541502180565485980503646440548199239100050792877003355816639229553136239076508735759914822574862575007425302077447712589550957937778424442426617334727629299387668709205606050270810842907692932019128194467627007
    @generatorG = 2
    
    keyAlice = r.rand(10000000000000000000) * (2**800)-1
    keyBob = r.rand(10000000000000000000) * (2**800)-1
    
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
          studentfactory.approveProject3(@username)
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