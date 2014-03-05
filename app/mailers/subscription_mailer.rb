# encoding: UTF-8
# Send emails to the followers of post author.

class SubscriptionMailer < ActionMailer::Base
  default from: 'info@savitri.in', reply_to: 'info@savitri.in'

  add_template_helper ApplicationHelper

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
