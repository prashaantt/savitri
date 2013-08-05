atom_feed :language => 'en-US', :id => request.protocol + request.host_with_port + '/blogs/' + @feedsrc.first.blog.slug do |feed|

  feed.title @feedsrc.first.blog.title
  feed.updated @feedsrc.first.updated_at

  @feedsrc.first(15).each do |post|
    next if post.updated_at.blank?
    @link = request.protocol + request.host_with_port + blog_post_path(post.blog, post)
    feed.entry(post, :url => @link, :id => request.protocol + request.host_with_port + blog_post_path(post.blog, post)) do |entry|
      entry.title post.title
      if (post.excerpt && post.excerpt.length > 0)
        entry.summary post.excerpt.gsub(/\r\n?/,"<br>").html_safe
      elsif (post.content && post.content.length > 0)
        entry.summary strip_tags(post.content).first(500) + "..."
      end
      entry.content post.content, :type => "html"
      entry.author do |author|
        author.name post.blog.user.username
      end
    end
  end
end
