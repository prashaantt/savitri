class CommentWorker
  include Sidekiq::Worker

  def perform(user_id, comment)
    @sender = User.find(user_id)
    @users = @sender.user_followers.select do |u|
        # if invited user then check if invitation accepted
        u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
      end
    @comment = Comment.find_by_id(comment)
    @post = Post.find_by_id(@comment.post)
    @users_followers = []
    @users.each do |up|
      @users_followers << up.id
    end
    @early_commenters = @post.comments.pluck(:user_id)
    @blog = Blog.find(@post.blog_id)
    @list_to_send_to = @early_commenters | @users_followers || @post.author_id
    @list_to_send_to.each do |reciever|
      CommentMailer.comment_notification_email(User.find(reciever), @sender, @blog, @post, @comment).deliver!
    end
  end
end
