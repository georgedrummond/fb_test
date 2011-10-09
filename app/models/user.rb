class User
  attr_accessor :uid, :graph

  def initialize(graph, uid)
    @graph = graph
    @uid = uid
  end
  
  def info
    @info ||= graph.get_object(uid)
  end
  
  def friends
    @friends ||= graph.get_connections(uid, 'friends').sort_by { |f| f['name'] }
  end
  
  def top_commenters
    @comments_count = Hash.new(:name => "", :count => 0) # Store our comment count in a hash
    
    @posts ||= graph.get_connections(uid, 'feed', :limit => 100) # Get last 100 posts
    @posts.each do |post|
      post['comments']['data'].to_a.each do |comment|
        id = comment['from']['id']
        @comments_count[id] = { :name => comment['from']['name'], :count => @comments_count[id][:count]+1} # Increment comment count by 1 for that friend
      end
    end
    return @comments_count.sort { |a, b| b[1][:count] <=> a[1][:count] } # return our sorted hash
  end
end
