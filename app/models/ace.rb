class Ace
  attr_accessor :nbr, :type, :objecttype, :inheritedobjecttype, :accessrights, :principal
  
  def initialize(nbr)
    @nbr = nbr
    @type = "Access_allowed_object_ace"
    @objecttype = "GUID for web home page"
    @inheritedobjecttype = "GUID for user account objects"
    @accessrights = ["write"]
    @principal = "principal_self"
  end 
end