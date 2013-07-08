class SubscriptionMailer < ActionMailer::Base
  default from: "admin@savitri.in"

  def blogpost_email(reciever, sender, blog, post)
    @reciever = reciever
    @sender = sender
    @blog = blog
    @post = post 
    @url  = "http://savitri.in"
    mail(:to => reciever.email, :subject => "#{sender.username} just posted on the blog")
  end
end
