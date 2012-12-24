class EmailWorker
  include Sidekiq::Worker 

  def perform(user_id)
  	@sender = User.find(user_id)
  	@users= @sender.user_followers
    @users.each do |reciever|
      SubscriptionMailer.blogpost_email(reciever,@sender).deliver
    end 
  end
end
