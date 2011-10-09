require 'spec_helper'

describe FacebookController do
  
  describe 'login with GET' do
    context "when not logged in" do
      before do
        get :login
      end

      it do
        response.should be_success
      end
    end
    
    context "when logged in" do
      before do
        @oauth = mock('oauth')
        @graph = mock('graph')
        @user = User.new(mock('graph'), 42)
        
        Koala::Facebook::OAuth.should_receive(:new).and_return(@oauth)
        user_info = {'access_token' => '1234567890', 'uid' => 42}
        @oauth.should_receive(:get_user_info_from_cookie).and_return(user_info)
        Koala::Facebook::GraphAPI.should_receive(:new).with('1234567890').and_return(@graph)
        User.should_receive(:new).and_return(@user)
          
        get :login
      end
      it "should redirect to friends_path" do
        response.should redirect_to(friends_path)
      end
    end
  end
end
