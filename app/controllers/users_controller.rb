class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    @users.sort! { |a,b| a.lastNameStil1.downcase <=> b.lastNameStil1.downcase }
    if !params[:sha].nil? then
      @sha1sum = `echo "#{params[:sha]['userName']}EIT060_2011_P1" | sha1sum | head -c 4`
    end

    @count = @users.count
    @users.each { |u| @count += u.stil2.empty? ? 0 : 1 }

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
  
  def sha1sum
    #@userName = 
  end
end
