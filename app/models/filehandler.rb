# -*- coding: utf-8 -*-

class Filehandler < ActiveRecord::Base
  def self.save(file)
    filename = file['File'].original_filename
    
    File.open('compseckeystore', "wb") { |f| f.write(file['File'].read)}
    return filename
  end
  
  def self.approve(password)
   
    # Check that the password is correct
    if password.empty?
      return "Password can not be empty"
    elsif !`keytool -list -v -keystore "compseckeystore" -storepass #{password} | grep -c 'Keystore was tampered with, or password was incorrect'`["2"].nil? then
      return "The password was incorrect"
    end

    # Check if the certificate chain matches 2
    if !`keytool -list -v -keystore "compseckeystore" -storepass #{password} | grep -c 'kedja: 2'`["1"].nil? then
      return "Congratulations, your certifcate has the correct length of 2"
    else
      return "Sorry, your certificate chain does not contain the correct number of certificates"
    end
  end
  
  def self.cleanup
    if File.exist?('compseckeystore') then
      File.delete('compseckeystore') 
    end
  end
end
