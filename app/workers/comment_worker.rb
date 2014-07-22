# encoding: UTF-8
# Send emails to all followers of commenter and blog.
# and to people who have already commented to the post.
class CommentWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 5 # Only five retries and then to the Dead Job Queue

  def perform(user_id, params,force=false)
    # Set force true when you want to skip verify_time & verify_recent_comment.
    logger.info "\n\tuser_id: #{user_id},\n\tparams: #{params}"
    response_json = disqus_api_call(params['disqus_comment_id'])
    # Send notifications when server time and disqus comment time diff is max 1 min
    # Also if comment is in last 5 comments then only send notification
    if (verify_time(response_json['response']['createdAt']) && verify_recent_comment(params['disqus_comment_id'])) or force == true
      @post = Post.cached_find_by_url(params["post_id"])
      @comment = response_json["response"]["raw_message"]
      @blog = Blog.find(@post.blog_id)
      @sender = response_json["response"]["author"]["name"] #disqus name
      list_to_send_to = commenters_followers(user_id) | blog_followers(@blog) | [User.cached_find(@post.author_id)]
      list_to_send_to.each do |receiver|
        CommentMailer.comment_notification_email(
        receiver, @sender, @blog, @post, @comment, response_json["response"]["url"]).deliver!
      end
    else
      logger.warn "Unauthorized #{params}"
    end
  end

  def disqus_api_call disqus_comment_id
    url = "http://disqus.com/api/3.0/posts/details.json?api_secret=#{DISQUS_SECRET_KEY}&post=#{disqus_comment_id}&related=thread"
    uri = URI.parse(url)
    response = Net::HTTP.get(uri)
    sleep 5
    JSON.parse(response)
  end

  def blog_followers blog
    blog.user_followers.select do |u|
      # if invited user then check if invitation accepted
      u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
    end
  end

  def commenters_followers user_id
    if user_id.nil?
    # if current user is not signed in to savitri
    # user is commenting using disqus account, So can't find followers in savitri    
      []
    else
      User.cached_find(user_id).user_followers.select do |u|
        # if invited user then check if invitation accepted
        u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
      end
    end
  end

  def verify_time comment_createdAt
    (Time.zone.now - Time.parse(comment_createdAt+"+0000")) < 15 ? true : false
  end

  def verify_recent_comment disqus_comment_id
    comment_url = "http://disqus.com/api/3.0/forums/listPosts.json?forum=#{DISQUS_FORUM}&limit=10&related=thread&api_key=#{DISQUS_PUBLIC_KEY}"
    comment_uri = URI.parse(comment_url)
    recent_comment = Net::HTTP.get(comment_uri)
    recent_comment = JSON.parse(recent_comment)
    recent_comment['response'].map{|m| m['id']}.include? disqus_comment_id
  end
end
