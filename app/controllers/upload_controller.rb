class UploadController < ApplicationController
  def index
    
  end
  
  def create
    @filename = Filehandler.save(params[:file])
    response = Filehandler.run(params[:password]['Password'])
    @HtmlResponse = response.gsub("\n", '<br>')
    
    @cmd = Filehandler.approve(response)
    Filehandler.cleanup
    @notice = @filename + ' was successfully uploaded'
  end
end
