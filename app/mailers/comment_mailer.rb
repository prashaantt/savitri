# encoding: UTF-8
# Comment mailer.
class CommentMailer < ActionMailer::Base
  default from: 'info@savitri.in', reply_to: 'info@savitri.in'

  add_template_helper ApplicationHelper

  def comment_notification_email(reciever, sender, blog, post, comment)
    @reciever, @comment, @sender, @blog = reciever, comment, sender, blog
    @post = post
    if @sender.name.blank?
      name = @sender.name
    else
      name = @sender.username
    end
    mail(to: reciever.email, subject: "#{name} wrote a comment on\
    '#{blog.title}'")
  end
end
