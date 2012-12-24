class SubscriptionMailer < ActionMailer::Base
  default from: "emailsender@kryptonlabs.com"

  def blogpost_email(reciever,sender)
    @reciever = reciever
    @sender = sender
    @url  = "http://revealinghour.in"
    mail(:to => reciever.email, :subject => "#{sender.username} just posted on the blog")
  end
end
