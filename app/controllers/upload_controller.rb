class UploadController < ApplicationController
  def index
    
  end
  
  def create
    file = Filehandler.new(params[:file], params[:password]['Password'])

    @HtmlResponse = file.data.gsub("\n", '<br>')
    @cmd = file.approve().gsub("\n", '<br>')
    @notice = file.filename + ' was successfully uploaded'
  end
end
