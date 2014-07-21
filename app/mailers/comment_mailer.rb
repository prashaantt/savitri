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
    mail(:to => reciever.email, :subject => "#{@sender} wrote a comment on '#{blog.title}'")
  end
end
