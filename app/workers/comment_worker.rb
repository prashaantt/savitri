# encoding: UTF-8
# Send emails to all followers of commenter and blog.
# and to people who have already commented to the post.
class CommentWorker
  include Sidekiq::Worker

  def perform(user_id, params)
    @sender = User.cached_find(user_id)
    disqusApiSecret = 'ZIfe5LCHZ6VK920YUj2LIVEt4H5T8CfPhC1j75ikovOkPnNGLIUJDuNfsZ9cX8TG'
    url = "http://disqus.com/api/3.0/posts/details.json?api_secret=#{disqusApiSecret}&post=#{params['disqus_comment_id']}&related=thread"
    uri = URI.parse(url)
    response = Net::HTTP.get(uri)
    sleep 5
    response_json = JSON.parse(response.gsub('\"', '"'))
    @post = Post.cached_find_by_url(params["post_id"])
    @comment = response_json["response"]["raw_message"]
    users_followers = @sender.user_followers.select do |u|
      # if invited user then check if invitation accepted
      u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
    end
    @blog = Blog.find(@post.blog_id)
    blog_followers = @blog.user_followers.select do |u|
      # if invited user then check if invitation accepted
      u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
    end
    list_to_send_to = users_followers | blog_followers | [User.find(@post.author_id)]
    list_to_send_to.each do |receiver|
      CommentMailer.comment_notification_email(
      receiver, @sender, @blog, @post, @comment, response_json["response"]["url"]).deliver!
    end
  end
end
