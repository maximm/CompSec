# -*- coding: utf-8 -*-

class Filehandler < ActiveRecord::Base
  def self.save(file)
    filename = file['File'].original_filename
    
    File.open('C:\compseckeystore', "wb") { |f| f.write(file['File'].read)}
    return filename
  end
  
  def self.approve()
    if !`keytool -list -v -keystore "C:/compseckeystore" -storepass bestpassever123 | grep -c 'kedja: 2'`["1"].nil? then
      return "Grattis, din certifikatkedja är korrekt"
    else
      return "Tyvärr, din certifkatkedja har inte längd 2"
    end
  end
end
