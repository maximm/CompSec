# -*- coding: utf-8 -*-

class Filehandler < ActiveRecord::Base
  def self.save(file)
    filename = file['File'].original_filename
    
    File.open('C:/compseckeystore', "wb") { |f| f.write(file['File'].read)}
    return filename
  end
  
  def self.approve(password)
    #password = "bestpassever123" 
    # Check that the password is correct

    if !`keytool -list -v -keystore "C:/compseckeystore" -storepass #{password} | grep -c 'kedja: 2'`["1"].nil? then
      return "Congratulations, your certifcate has the correct length of 2"
    elsif !`keytool -list -v -keystore "C:/compseckeystore" -storepass #{password} | grep -c 'Keystore was tampered with, or password was incorrect'`["2"].nil? then
      return "The password was incorrect"
    else
      return "Sorry, your certificate chain does not contain the correct number of certificates"
    end
  end
  
  def self.cleanup
    if File.exist?('C:\compseckeystore') then
      File.delete('C:/compseckeystore') 
    end
  end

end
