# encoding: UTF-8
# Send emails to all followers of commenter and blog.
# and to people who have already commented to the post.
class CommentWorker
  include Sidekiq::Worker

  def perform(user_id, params)
    response_json = disqus_api_call(params['disqus_comment_id'])
    @post = Post.cached_find_by_url(params["post_id"])
    @comment = response_json["response"]["raw_message"]
    @blog = Blog.find(@post.blog_id)
    @sender = response_json["response"]["author"]["name"] #disqus name
    list_to_send_to = commenters_followers(user_id) | blog_followers(@blog) | [User.cached_find(@post.author_id)]
    list_to_send_to.each do |receiver|
      CommentMailer.comment_notification_email(
      receiver, @sender, @blog, @post, @comment, response_json["response"]["url"]).deliver!
    end
  end

  def disqus_api_call disqus_comment_id
    disqusApiSecret = 'ZIfe5LCHZ6VK920YUj2LIVEt4H5T8CfPhC1j75ikovOkPnNGLIUJDuNfsZ9cX8TG'
    url = "http://disqus.com/api/3.0/posts/details.json?api_secret=#{disqusApiSecret}&post=#{disqus_comment_id}&related=thread"
    uri = URI.parse(url)
    response = Net::HTTP.get(uri)
    sleep 5
    JSON.parse(response.gsub('\"', '"'))
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
end
