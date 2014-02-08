# encoding: UTF-8
# Send emails to all followers of commenter and blog.
# and to people who have already commented to the post.
class CommentWorker
  include Sidekiq::Worker

  def perform(user_id, comment)
    @sender = User.find(user_id)
    users = @sender.user_followers.select do |u|
      # if invited user then check if invitation accepted
      u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
    end
    @comment = Comment.find_by_id(comment)
    @post = Post.find_by_id(@comment.post)
    early_commenters = @post.comments.map { |com| com.user }
    @blog = Blog.find(@post.blog_id)
    blog_followers = @blog.user_followers.select do |u|
      # if invited user then check if invitation accepted
      u.invited_by_id.nil? || !u.invitation_accepted_at.nil?
    end
    list_to_send_to = early_commenters | users | blog_followers ||
                               @post.author_id
    list_to_send_to.each do |receiver|
      CommentMailer.comment_notification_email(
      receiver, @sender, @blog, @post, @comment).deliver!
    end
  end
end
