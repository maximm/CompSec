class UploadController < ApplicationController
  def index
    
  end
  
  def create
    file = Filehandler.new(params[:file], params[:password]['Password'])

    @KeyToolResponse = file.data.gsub("\n", '<br>')
    @ApprovalInfo = file.approve().gsub("\n", '<br>')
    @notice = file.filename + ' was successfully uploaded'
  end
end
