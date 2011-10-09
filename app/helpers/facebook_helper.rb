module FacebookHelper
  def facebook_login_button(size='large')
    content_tag("fb:login-button", nil , {
      :perms => 'friends_status, friends_activities, friends_videos, friends_relationships, friends_photos, friends_notes, friends_likes, friends_location, friends_events, friends_checkins, read_stream, friends_about_me',
      :id => "fb_login",
      :autologoutlink => 'true',
      :size => size,
      :onlogin => 'location = "/"'})
  end
end
