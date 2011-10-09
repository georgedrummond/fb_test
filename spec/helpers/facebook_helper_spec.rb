require 'spec_helper'

describe FacebookHelper do
  describe "facebook_login_button" do
    it "should return the correct fbml" do
      helper.facebook_login_button.should == '<fb:login-button autologoutlink="true" id="fb_login" onlogin="location = &quot;/&quot;" perms="friends_status, friends_activities, friends_videos, friends_relationships, friends_photos, friends_notes, friends_likes, friends_location, friends_events, friends_checkins, read_stream, friends_about_me" size="large"></fb:login-button>'
    end
  end
end
