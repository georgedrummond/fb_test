class FriendsController < ApplicationController  
  def index
    @friends = current_user.friends
  end
  
  def show
    @friend = User.new(@graph, params[:id])
    @top_commenters = @friend.top_commenters
  end
end
