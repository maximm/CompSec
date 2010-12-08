class UploadController < ApplicationController
  def index
    
  end
  
  def create
    @filename = Filehandler.save(params[:file])
    @cmd = Filehandler.approve(params[:password]['Password'])
    Filehandler.cleanup
    @notice = @filename + ' was successfully uploaded'
  end
end
