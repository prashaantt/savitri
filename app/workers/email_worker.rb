class EmailWorker
  include Sidekiq::Worker 

  def perform(user_id, post)
  	@sender = User.find(user_id)
  	@users= @sender.user_followers
  	@post = Post.find_by_id(post)
  	@blog = Blog.find(@post.blog_id)
    @users.each do |reciever|
      SubscriptionMailer.blogpost_email(reciever, @sender, @blog, @post).deliver
    end 
  end
end
