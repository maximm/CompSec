class UploadController < ApplicationController
  def index
    
  end
  
  def create
    studentfactory = Studentfactory.new
    if params[:file].nil? then
      redirect_to "/"
    else
      file = Filehandler.new(params[:file], params[:password]['Password'], params[:stil1]['stil'])
  
      @KeyToolResponse = file.data.gsub("\n", '<br>')
      @ApprovalInfo = file.approve().gsub("\n", '<br>')
      @approved = file.approved
      
      su1 = params[:stil1]
      su2 = params[:stil2]
      name1 = su1[:stil]
      name2 = su2[:stil]
      
      
      @approvedText = ""
      if(@approved == true) then
        studentfactory.approveProject0(name1)
        @receipt = "Your receipt for #{name1} is <b>" + `echo "#{name1}EIT060_2011_P1" | sha1sum | head -c 4` + "</b>. Please save this as a token for finishing Project 1"
        if !name2.empty? then
          studentfactory.approveProject0(name2)
          @receipt +="<br>Your receipt for #{name2} is <b>" + `echo "#{name2}EIT060_2011_P1" | sha1sum | head -c 4` + "</b>. Please save this as a token for finishing Project 1"
        end
        @approvedText = "<font color=green size=+2>Congratulations! Project 1 approved</font>"
        if User.find_by_stil1(name1).nil? then
          User.new(:stil1 => su1['stil'], :firstNameStil1 =>su1['fName'], :lastNameStil1 => su1['lName'], :stil2 => su2['stil'], :firstNameStil2 =>su2['fName'], :lastNamestil2 => su2['lName']).save
        elsif User.find_by_stil2(name2).nil? then
          #User.find_by_stil1(name1).destroy
          User.new(:stil1 => su1['stil'], :firstNameStil1 =>su1['fName'], :lastNameStil1 => su1['lName'], :stil2 => su2['stil'], :firstNameStil2 =>su2['fName'], :lastNamestil2 => su2['lName']).save
        end
      else
        @receipt = ""
        @approvedText = "<font color=red size=+2>Project not approved</font>"
      end
        
      @notice = file.filename + ' was successfully uploaded'
      end
    end
end
