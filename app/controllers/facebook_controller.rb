class FacebookController < ApplicationController

  before_filter :facebook_auth, :require_no_login
  skip_before_filter :require_login
  

  helper_method :logged_in?, :current_user
  

  def login
  end


end
