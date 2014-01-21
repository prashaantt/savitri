class PostAuthorEmailWorker
  include Sidekiq::Worker

  def perform(receiver_id, sender_id, blog)
    @receiver = User.find(receiver_id)
    @sender = User.find(sender_id)
    @blog = Blog.find(blog)
    AccessPostMailer.add_new_posts_email(@receiver, @sender, @blog).deliver!
  end
end
