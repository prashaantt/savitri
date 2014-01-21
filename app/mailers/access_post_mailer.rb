class AccessPostMailer < ActionMailer::Base
  default :from => "info@savitri.in",
          :reply_to => "info@savitri.in"

  def add_new_posts_email(receiver, sender, blog)
    @receiver, @sender, @blog = receiver, sender, blog
    mail(:to => receiver.email, :subject => "You can write posts on #{@blog.title}")
  end
end
