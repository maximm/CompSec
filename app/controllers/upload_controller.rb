class UploadController < ApplicationController
  def index
    
  end
  
  def create
    @filename = Filehandler.save(params[:file])
    @cmd = Filehandler.approve()
    @notice = @filename + ' Successfully uploaded'
  end
end
