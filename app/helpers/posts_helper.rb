module PostsHelper
  def join_tags(post)
    post.tags.map { |t| t.name }.join(", ")
  end

  def archives
    @posts_by_month = Posts.find(:all).group_by { |post| post.created_at.strftime("%B") }
  end
end