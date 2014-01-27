class InviteForBlogWorker
  include Sidekiq::Worker

  def perform(receiver_id, sender_id, blog_id)
    @receiver = User.find(receiver_id)
    @sender = User.find(sender_id)
    @blog = Blog.find(blog_id)
    InviteForBlogMailer.invitation_mail(@receiver, @sender, @blog).deliver!
  end
end
