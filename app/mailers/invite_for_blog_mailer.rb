class InviteForBlogMailer < ActionMailer::Base
  default :from => "info@savitri.in",
          :reply_to => "info@savitri.in"

  def invitation_mail(receiver, sender, blog)
    @receiver, @sender, @blog = receiver, sender, blog
    mail(to: receiver.email, subject: "#{ @sender.name || @sender.username } invited you to write posts at #{ @blog.title }")
  end
end
