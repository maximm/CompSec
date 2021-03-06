require "iconv"

class Filehandler
  attr_accessor :data, :filename, :stil, :approved, :id, :filepath
  
  def initialize(file, password, stil)
    if password.empty? then
      password = ".EMPTY."
    end
    
    @filepath = "#{RAILS_ROOT}/tmp/compsec_#{rand(99999999999)}"
    Thread.new do
      File.open(filepath, "wb") { |f| f.write(file['File'].read)}
    end
    
    @filename = file['File'].original_filename
    output = `keytool -list -v -keystore "#{filepath}" -storepass #{password}`
    
    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
    @data = ic.iconv(output + ' ')[0..-2]
    
    @stil = stil
    self.cleanup()
  end
  
  def approve()

    @ApprovedList = String.new
    @approved = true
    
    # Is this a Keystore file?
    if @data.match("Invalid keystore format") then
      @approved = false
      return "ERROR: The uploaded file is invalid"
    end
        
    # Is the password correct?
    if @data.match("Keystore was tampered with, or password was incorrect") then
      @approved = false
      return "ERROR: The password was incorrect"
    end
    
    # STIL-Login approved
    if @data.match("CN="+@stil+"\n") || @data.match("CN="+@stil+",") then
      @ApprovedList += "OK: STIL-Identity present\n"
    else
      @approved = false
      @ApprovedList += "ERROR: Stil-Identity not present\n"
    end
      
    
    # 2 Entries
    if @data.match("Your keystore contains 2 entries") then
      @ApprovedList += "OK: Your keystore contains 2 entries\n"
    else
      @approved = false
      @ApprovedList += "ERROR: Your keystore does not contain 2 entries\n"
      @ApprovedList += "<ul><li>Did you import both the CA and client cert into the keystore?</ul>"
    end
    
    # Certificate Chain for second certificate matches 2
    if @data.match("Certificate chain length: 2") then
      @ApprovedList += "OK: Your certificate chain has the correct length of 2\n"
    else
      @approved = false
      @ApprovedList += "ERROR: Your certificate chain does not contain the correct number of certificates\n"
      @ApprovedList += "<ul><li>The most common error for this is not setting the alias correctly for each step. Make sure to set the same alias when creating the keypair, CSR and when importing the certificate into the keystore so as to correctly match all of them.</ul>"
      @ApprovedList += "<ul><li>Make sure that the CA is imported into the Keystore before the User Certificate</ul>"
      @ApprovedList += "<ul><li>Did you remember to use -CAcreateserial option?</ul>"
    end
    
    # One certificate is of type : Entry type: trustedCertEntry
    if @data.match("Entry type: trustedCertEntry") then
      @ApprovedList += "OK: Your Keystore contains a CA:s certificate\n"
    else
      @approved = false
      @ApprovedList += "ERROR: Your keystore does not contain a certificate belonging to a CA\n"
      @ApprovedList += "<ul><li>Don't forget to import the CA:s certificate into the Keystore.</ul>"
    end
  end
  
  def cleanup
    if File.exist?(@filepath) then
      File.delete(@filepath)
    end
  end
end