class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :logged_in?, :current_user
  before_filter :facebook_auth, :require_login

  def logged_in?
    !!@user
  end

  def current_user
    @user
  end
  
  def require_no_login
    redirect_to friends_path if logged_in?
  end

  def require_login
    unless logged_in?
      redirect_to :controller => :facebook, :action => :login
    end
  end

  def facebook_auth
    @oauth = Koala::Facebook::OAuth.new(FACEBOOK_APP_ID, FACEBOOK_SECRET_KEY)
    if fb_user_info = @oauth.get_user_info_from_cookie(request.cookies)
      @graph = Koala::Facebook::GraphAPI.new(fb_user_info['access_token'])
      @user = User.new(@graph, fb_user_info['uid'])
    end
  end
end
