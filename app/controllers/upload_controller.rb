class UploadController < ApplicationController
  def index
    
  end
  
  def create
    if params[:file].nil? then
      redirect_to "/"
    else
      file = Filehandler.new(params[:file], params[:password]['Password'], params[:stil]['STIL'], params[:stil2]['STIL2'] )
  
      @KeyToolResponse = file.data.gsub("\n", '<br>')
      @ApprovalInfo = file.approve().gsub("\n", '<br>')
      @approved = file.approved
      
      name1 = params[:stil]['STIL']
      name2 = params[:stil2]['STIL2']
      
      @approvedText = ""
      if(@approved == true) then
        @receipt = "Your receipt for #{name1} is <b>" + `echo "#{name1}EIT060_2011_P1" | sha1sum | head -c 4` + "</b>. Please save this as a token for finishing Project 1"
        if !name2.empty? then
          @receipt +="<br>Your receipt for #{name2} is <b>" + `echo "#{name2}EIT060_2011_P1" | sha1sum | head -c 4` + "</b>. Please save this as a token for finishing Project 1"
        end
        @approvedText = "<font color=green size=+2>Congratulations! Project approved</font>"
        if User.find_by_name(name1).nil? then
          User.new(:name => name1).save
        end
        if !name2.empty? && User.find_by_name(name2).nil? then
          User.new(:name => name2).save
        end
      else
        @receipt = ""
        @approvedText = "<font color=red size=+2>Project not approved</font>"
      end
        
      @notice = file.filename + ' was successfully uploaded'
      end
    end
end
