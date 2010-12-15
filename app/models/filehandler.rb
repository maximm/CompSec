# -*- coding: utf-8 -*-

class Filehandler
  attr_accessor :data, :filename
  
  def initialize(file, password)
    File.open('compseckeystore', "wb") { |f| f.write(file['File'].read)}
    
    @filename = file['File'].original_filename   
    @data = `keytool -list -v -keystore "compseckeystore" -storepass #{password}`
    self.cleanup()
  end
  
  def approve()

    @ApprovedList = String.new
    
    # Check if password is correct
    if @data.match("Keystore was tampered with, or password was incorrect") then
      return "ERROR: The password was incorrect"
    end

    # Check if the certificate chain matches 2
    if @data.match("Certificate chain length: 2") then
      @ApprovedList += "OK: Your certificate has the correct length of 2\n"
    else
      @ApprovedList += "ERROR: Sorry, your certificate chain does not contain the correct number of certificates\n"
    end
    
    # Check if keystore contains 2 entries
    if @data.match("Your keystore contains 2 entries") then
      @ApprovedList += "OK: Your keystore contains 2 entries\n"
    else
      @ApprovedList += "ERROR: Sorry, your keystore does not contain 2 entries\n"
    end
  end
  
  def cleanup
    if File.exist?('compseckeystore') then
      File.delete('compseckeystore') 
    end
  end
end