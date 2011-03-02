class LinuxController < ApplicationController
  def index
    @linux = Linux.new()
  end
end
