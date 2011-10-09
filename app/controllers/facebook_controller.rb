class FacebookController < ApplicationController
  before_filter :facebook_auth, :require_no_login
  skip_before_filter :require_login
  
  def login
    
  end
end
