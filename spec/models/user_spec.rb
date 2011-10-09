require 'spec_helper'

describe User do
  before do
    @graph = mock('graph api')
    @uid = 42
    @user = User.new(@graph, @uid)
  end
  
  describe "finding friends" do
    before do
      @friends = mock('friends')
      @friends.should_receive(:sort_by).and_return(@friends)
      @graph.should_receive(:get_connections).with(@uid, 'friends').and_return(@friends)
    end
    it "should return users friends sorted alphabetically" do
      @user.friends.should == @friends
    end
  end
  
  describe "getting user info" do
    before do
      @graph.should_receive(:get_object).with(@uid).and_return(@user)
    end
    
    it "should return user info" do
      @user.info.should == @user
    end
  end
  
  describe "top_commenters" do
    before do
      @feed = mock('feed')
      @top_commenters = mock('top_commenters')
      @comments = mock('comments')
      @graph.should_receive(:get_connections).with(@uid, 'feed', :limit => 100).and_return(@feed)
      @feed.stub!(:each).and_return(@feed)
      @top_commenters.should_receive(:sort).and_return(@top_commenters)
      Hash.should_receive(:new).and_return(@top_commenters)
    end
    
    it "should return the hash of most recent commenters" do
      @user.top_commenters.should == @top_commenters
    end 
  end
end
