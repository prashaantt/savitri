atom_feed :language => 'en-US' do |feed|

  feed.title @posts.first.blog.title

  @posts.each do |post|
    next if post.updated_at.blank?
    @link = request.protocol+request.host_with_port+blog_post_path(post.blog,post)
    feed.entry( post, :url => @link ) do |entry|
      entry.url h(@link)
      entry.title h(post.title)
      entry.summary strip_tags(post.content).first(200)
      entry.content post.content, :type => "html"

      # the strftime is needed to work with Google Reader.
      entry.updated(post.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 
      entry.author do |author|
        author.name post.blog.user.username
      end
    end
  end
end