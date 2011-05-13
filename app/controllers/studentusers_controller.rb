class StudentusersController < ApplicationController
  # GET /studentusers
  # GET /studentusers.xml
  def index
    @studentusers = Studentuser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @studentusers }
    end
  end

  # GET /studentusers/1
  # GET /studentusers/1.xml
  def show
    @studentuser = Studentuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @studentuser }
    end
  end

  # GET /studentusers/new
  # GET /studentusers/new.xml
  def new
    @studentuser = Studentuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @studentuser }
    end
  end

  # GET /studentusers/1/edit
  def edit
    @studentuser = Studentuser.find(params[:id])
  end

  # POST /studentusers
  # POST /studentusers.xml
  def create
    @studentuser = Studentuser.new(params[:studentuser])

    respond_to do |format|
      if @studentuser.save
        format.html { redirect_to(@studentuser, :notice => 'Studentuser was successfully created.') }
        format.xml  { render :xml => @studentuser, :status => :created, :location => @studentuser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @studentuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /studentusers/1
  # PUT /studentusers/1.xml
  def update
    @studentuser = Studentuser.find(params[:id])

    respond_to do |format|
      if @studentuser.update_attributes(params[:studentuser])
        format.html { redirect_to(@studentuser, :notice => 'Studentuser was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @studentuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /studentusers/1
  # DELETE /studentusers/1.xml
  def destroy
    @studentuser = Studentuser.find(params[:id])
    @studentuser.destroy

    respond_to do |format|
      format.html { redirect_to(studentusers_url) }
      format.xml  { head :ok }
    end
  end
end
