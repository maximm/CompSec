class UploadController < ApplicationController
  def index
    
  end
  
  def create
    file = Filehandler.new(params[:file], params[:password]['Password'], params[:stil]['STIL'], params[:stil2]['STIL2'] )

    @KeyToolResponse = file.data.gsub("\n", '<br>')
    @ApprovalInfo = file.approve().gsub("\n", '<br>')
    @approved = file.approved
    
    
    @approvedText = ""
    if(@approved == true) then
      @receipt = "Your receipt = <b>" + `echo "#{params[:stil]['STIL']}EIT060_2011_P1" | sha1sum | head -c 4` + "</b>. Please save this as a token for finishing Project 1"
      @approvedText = "<font color=green size=+2>Congratulations! Project approved</font>"
    else
      @receipt = ""
      @approvedText = "<font color=red size=+2>Project not approved</font>"
    end
      
    @notice = file.filename + ' was successfully uploaded'
  end
end
