require 'spec_helper'

describe FriendsController do
  
  before do
    @user = User.new(mock('graph'), 42)
    @oauth = mock('oauth')
    @graph = mock('graph')
    Koala::Facebook::OAuth.should_receive(:new).and_return(@oauth)
    user_info = {'access_token' => '1234567890', 'uid' => 42}
    @oauth.should_receive(:get_user_info_from_cookie).and_return(user_info)
    Koala::Facebook::GraphAPI.should_receive(:new).with('1234567890').and_return(@graph)

  end
  
  describe 'index with GET' do
    context 'when logged into facebook' do
      before do
        User.should_receive(:new).and_return(@user)
        @friends = mock('friends')
        @user.should_receive(:friends).and_return(@friends)
        get :index
      end

      it do
        response.should be_success
      end

      it 'should assign friends' do
        assigns[:friends].should == @friends
      end
    end
  end
  
  describe 'show with GET' do
    context 'when logged into facebook' do
      before do
        @top_commenters = mock('top_commenters')
        
        @friend = mock('friend')
        User.should_receive(:new).exactly(2).times.and_return(@friend)
        @friend.should_receive(:top_commenters).and_return(@top_commenters)
        
        get :show, :id => 1
      end

      it do
        response.should be_success
      end
      
      it "should assign friend" do
        assigns[:friend].should == @friend
      end

      it 'should assign top commenters' do
        assigns[:top_commenters].should == @top_commenters
      end
    end
  end
  
end


