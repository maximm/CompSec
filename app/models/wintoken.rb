class Wintoken
  attr_accessor :user, :groups, :restrictedsid
  def initialize(user, groups)
    @user = user
    @groups = groups
    if groups[0] == "" then
      @groups = ["NONE"]
    end
    @restrictedsid = "NONE"
  end

  def to_s
    @user
  end
end