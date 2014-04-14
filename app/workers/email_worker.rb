# encoding: UTF-8
# EmailWorker is for sending emails to followers of poster.
class EmailWorker
  include Sidekiq::Worker

  def perform(user_id, post)
    @sender = User.find(user_id)
    @users = @sender.user_followers.select do |u|
      # if invited user then check if invitation accepted
      u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
    end
    @users.unshift @sender unless @sender.username == 'admin'
    @post = Post.find_by_id(post)
    unless @post.nil? # If Post has not been deleted by the time of publishing.
      # Check to do not send email multiple times for same post.
      if @post.draft == true
        @post.publish!
        @blog = Blog.find(@post.blog_id)
        @users << @blog.user_followers.select do |u|
          # if invited user then check if invitation accepted
          u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
        end
        @users.flatten.uniq.each do |reciever|
          SubscriptionMailer.blogpost_email(reciever, @sender, @blog, @post)
          .deliver
        end
      end
    end
  end
end
