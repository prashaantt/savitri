class CommentWorker
  include Sidekiq::Worker 

  def perform(user_id, comment)
  	@sender = User.find(user_id)
  	@users= @sender.user_followers
    @comment = Comment.find_by_id(comment)
  	@post = Post.find_by_id(@comment.post)
    @users_followers = Array.new
    @users.each do |up|
      @users_followers << up.id
    end
    @early_commenters = Array.new
    @post.comments.each do |pc|
      @early_commenters << pc.user.id
    end
    @blog = Blog.find(@post.blog_id)
    @list_to_send_to = @early_commenters | @users_followers || @post.user.id
    @list_to_send_to.each do |reciever|
      CommentMailer.comment_notification_email(User.find(reciever), @sender, @blog, @post, @comment).deliver!
    end 
  end
end
