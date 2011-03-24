class LinuxController < ApplicationController
  def index

    @linux = Linux.new(params)
  end
  
  def create
    @linux = Linux.new(params)
  end
end
