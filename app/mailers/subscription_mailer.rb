# encoding: UTF-8
# Send emails to the followers of post author.

class SubscriptionMailer < ActionMailer::Base
  default from: 'Savitri <info@savitri.in>', reply_to: 'info@savitri.in'

  def blogpost_email(reciever, sender, blog, post)
    @reciever = reciever
    @sender = sender
    @name = (@sender.name.blank? ? @sender.username : @sender.name)
    @blog = blog
    @post = post
    mail(to: reciever.email, subject: "#{ @name } wrote a new post\
                                                    on '#{blog.title}'")
  end
end
