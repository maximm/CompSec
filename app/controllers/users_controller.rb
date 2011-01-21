class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    @users.sort! { |a,b| a.name.downcase <=> b.name.downcase }


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to("/supersecretusercontroller") }
      format.xml  { head :ok }
    end
  end
end
