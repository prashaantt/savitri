class CommentMailer < ActionMailer::Base
  default :from => "admin@savitri.in"
  	   :reply_to => "admin@savitri.in"

  def comment_notification_email(reciever, sender, blog, post, comment)
    @reciever = reciever
    @comment = comment
    @sender = sender
    @blog = blog
    @post = post 
    @url  = "http://savitri.in"
    if @sender.name.blank?
      name = @sender.name 
    else
      name = @sender.username
  	end
    mail(:to => reciever.email, :subject => "#{name} wrote a comment on '#{blog.title}'")
  end
end
