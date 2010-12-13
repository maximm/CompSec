# -*- coding: utf-8 -*-

class Filehandler < ActiveRecord::Base
  
  # Save the file to disk
  def self.save(file)
    filename = file['File'].original_filename
    
    File.open('compseckeystore', "wb") { |f| f.write(file['File'].read)}
    return filename
  end
  
  # Run Keytool on the keystore
  def self.run(password)
    return data = `keytool -list -v -keystore "compseckeystore" -storepass #{password}`
  end
  
  def self.approve(data)

    if data.match("Keystore was tampered with, or password was incorrect") then
      return "The password was incorrect"
    end

    # Check if the certificate chain matches 2
    if data.match("Certificate chain length: 2") then
      return "Congratulations, your certificate has the correct length of 2"
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
