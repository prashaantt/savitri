# encoding: UTF-8
# EmailWorker is for sending emails to followers of poster.
class EmailWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers

  def perform(user_id, post)
    @sender = User.find(user_id)
    @users = @sender.user_followers.select do |u|
      # if invited user then check if invitation accepted
      u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
    end
    @users.unshift @sender unless @sender.username == 'admin'
    @post = Post.find_by_id(post)
    unless @post.nil?
     # If Post has not been deleted by the time of publishing.
      # Check to do not send email multiple times for same post.
      if @post.draft == true
        @post.publish!
        @post.assign_post_number!
        @blog = Blog.find(@post.blog_id)
        @users << @blog.user_followers.select do |u|
          # if invited user then check if invitation accepted
          u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
        end
        @users.flatten.uniq.each do |reciever|
          SubscriptionMailer.blogpost_email(reciever, @sender, @blog, @post)
          .deliver
        end
      end
    end
    share_to_social_sites(@sender,@post)
  end

  def share_to_social_sites(sender, post)
    begin
      sender.authentications.each do |social_account|
        case social_account.provider
        when 'twitter'
          tweet_message = ''
          if post.title.length > 100
            tweet_message = "#{post.title[0..99]}... #{Rails.application.routes.url_helpers.blog_post_url(post.blog, post, host: 'savitri.in')} #Savitri"
          else
            tweet_message = "#{post.title} #{Rails.application.routes.url_helpers.blog_post_url(post.blog, post, host: 'savitri.in')} #Savitri"
          end
          social_account.tweet(tweet_message)
        end
      end
    rescue Exception => e
      logger.info "#{e}\n #{sender.username} #{post.url}"
    end
  end
end
