atom_feed :language => 'en-US', :id => request.protocol + request.host_with_port + '/blogs/' + @posts.first.blog.slug do |feed|

  feed.title @posts.first.blog.title
  feed.updated @posts.first.updated_at

  @posts.each do |post|
    next if post.updated_at.blank?
    @link = request.protocol + request.host_with_port + blog_post_path(post.blog, post)
    feed.entry( post, :url => @link, :id => request.protocol + request.host_with_port + blog_post_path(post.blog, post) ) do |entry|
      entry.title post.title
      entry.summary strip_tags(post.content).first(200)
      entry.content post.content, :type => "html"

      # the strftime is needed to work with Google Reader.
      entry.author do |author|
        author.name post.blog.user.username
      end
    end
  end
end
