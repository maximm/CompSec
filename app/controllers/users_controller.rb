class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    
    # Sorting
    @users.sort! { |a,b| a.lastNameStil1.downcase <=> b.lastNameStil1.downcase }  # Default sortmethod
    
    if !params[:sort].nil?
      if params[:sort] == "lname1" then
        @users.sort! { |a,b| a.lastNameStil1.downcase <=> b.lastNameStil1.downcase }
      elsif params[:sort] == "lname2" then
        @users.sort! { |a,b| a.lastNamestil2.downcase <=> b.lastNamestil2.downcase }
      elsif params[:sort] == "stil1" then
        @users.sort! { |a,b| a.stil1.downcase <=> b.stil1.downcase }
      elsif params[:sort] == "stil2" then
        @users.sort! { |a,b| a.stil2.downcase <=> b.stil2.downcase }
      elsif params[:sort] == "date" then
        @users.sort! { |a,b| a.created_at <=> b.created_at }        
      end
    end
    
    # Hashing of usersnames
    if !params[:sha].nil? then
      @sha1sum = `echo "#{params[:sha]['userName']}EIT060_2011_P1" | sha1sum | head -c 4`
    end

    # Count the number of approved stil names
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
