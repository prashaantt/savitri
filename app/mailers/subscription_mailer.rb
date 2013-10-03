class SubscriptionMailer < ActionMailer::Base
  default :from => "admin@savitri.in"
    	   :reply_to => "admin@savitri.in"

  def blogpost_email(reciever, sender, blog, post)
    @reciever = reciever
    @sender = sender
    @blog = blog
    @post = post 
    @url  = "http://savitri.in"
    if @sender.name.blank?
      name = @sender.name 
    else
      name = @sender.username
  	end
    mail(:to => reciever.email, :subject => "#{name} wrote a new post on '#{blog.title}'")
  end
end
