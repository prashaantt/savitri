atom_feed :language => 'en-US', :id => @feed_url do |feed|
  title = @user.name.blank? ? @user.username : @user.name
  feed.title title + " on " + request.host_with_port
  feed.updated @feedsrc.blank? ? @user.updated_at : @feedsrc.first.updated_at

  unless @feedsrc.empty?
    @feedsrc.first(15).each do |post|
      next if post.updated_at.blank?
      @link = request.protocol + request.host_with_port + blog_post_path(post.cached_blog, post)
      feed.entry(post, :url => @link, :id => request.protocol + request.host_with_port + blog_post_path(post.cached_blog, post)) do |entry|
        title = ""
        unless post.cached_series_title.blank?
          title += post.cached_series_title + ": "
        end
        title += post.cached_title
        unless post.cached_subtitle.blank?
          title += " — " + post.cached_subtitle
        end
        entry.title title
        if (post.excerpt && post.cached_excerpt.length > 0)
          entry.summary post.cached_excerpt.gsub(/\r\n?/,"<br>").html_safe
        else
          post_content = post.cached_content.gsub(/\r\n?/, "")
          stripped_content = strip_tags(post_content)
          if stripped_content.split(" ").length > 200
            entry.summary strip_tags(post_content.split(" ").first(200).join(" ")) + "..."
          else
            entry.summary strip_tags(post_content.split(" ").first(200).join(" "))
          end
        end
        content = ""
        if post.cached_show_excerpt === "prefix"
          content = "<p>" + post.cached_excerpt + "</p>"
        end
        content += post.cached_content
        if post.cached_show_excerpt === "suffix"
          content += "<p>" + post.cached_excerpt + "</p>"
        end
        entry.content content, :type => "html"
        entry.author do |author|
          author.name post.cached_blog.cached_user.cached_username
        end
      end
    end
  end
end
