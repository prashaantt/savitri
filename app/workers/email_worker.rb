class EmailWorker
  include Sidekiq::Worker

  def perform(user_id, post)
    @sender = User.find(user_id)
    @users = @sender.user_followers.select do |u|
      # if invited user then check if invitation accepted
      u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
    end
    @post = Post.find_by_id(post)
    unless @post.nil? # If Post has not been deleted by the time of publishing.
      @post.publish!
      @blog = Blog.find(@post.blog_id)
      @users.each do |reciever|
        SubscriptionMailer.blogpost_email(reciever, @sender, @blog, @post).deliver
      end
    end
  end
end
