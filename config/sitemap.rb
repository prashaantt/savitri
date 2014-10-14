# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.savitri.in"

SitemapGenerator::Sitemap.create do
  User.find_each do |user|
    add user_path(user), :lastmod => user.updated_at
  end
  Blog.find_each do |blog|
    add blog_path(blog), :lastmod => blog.updated_at
  end
  Post.where(draft:false).find_each do |post|
    add blog_post_path(post.blog,post), :lastmod => post.updated_at
  end
  Page.find_each do |page|
    add page_path(page), :lastmod => page.updated_at
  end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
