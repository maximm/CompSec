class Studentfactory
  def initialize
    
  end
  
  def approveProject0(stil)
    if Studentuser.find_by_stil(stil).nil?
      Studentuser.new(:stil => stil, :project0 => true).save
    else
      student = Studentuser.find_by_stil(stil)
      student.update_attributes(:project0 => true)
    end
  end

  def approveProject1(stil)
    if Studentuser.find_by_stil(stil).nil?
      Studentuser.new(:stil => stil, :project1 => true).save
    else
      student = Studentuser.find_by_stil(stil)
      student.update_attributes(:project1 => true)
    end
  end
  
  def approveProject2(stil)
    if Studentuser.find_by_stil(stil).nil?
      Studentuser.new(:stil => stil, :project2 => true).save
    else
      student = Studentuser.find_by_stil(stil)
      student.update_attributes(:project2 => true)
    end
  end  
  
  def approveProject3(stil)
    if Studentuser.find_by_stil(stil).nil?
      Studentuser.new(:stil => stil, :project3 => true).save
    else
      student = Studentuser.find_by_stil(stil)
      student.update_attributes(:project3 => true)
    end
  end 
  
  def approveProject4(stil)
    if Studentuser.find_by_stil(stil).nil?
      Studentuser.new(:stil => stil, :project4 => true).save
    else
      student = Studentuser.find_by_stil(stil)
      student.update_attributes(:project4 => true)
    end
  end   

  def approveProject5(stil)
    if Studentuser.find_by_stil(stil).nil?
      Studentuser.new(:stil => stil, :project5 => true).save
    else
      student = Studentuser.find_by_stil(stil)
      student.update_attributes(:project5 => true)
    end
  end
  
end