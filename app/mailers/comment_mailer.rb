class CommentMailer < ActionMailer::Base
  default :from => "Savitri <info@savitri.in>",
          :reply_to => "info@savitri.in"

  def comment_notification_email(reciever, sender, blog, post, comment, url)
    @reciever = reciever
    @comment = comment
    @sender = sender
    @blog = blog
    @post = post 
    @url  = url
    if @sender.name.blank?
      name = @sender.name 
    else
      name = @sender.username
  	end
    mail(:to => reciever.email, :subject => "#{name} wrote a comment on '#{blog.title}'")
  end
end
