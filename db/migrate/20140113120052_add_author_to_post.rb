class AddAuthorToPost < ActiveRecord::Migration
  def up
    add_column :posts, :author_id, :integer
    #Adding author_id to existing posts
    Post.find_each do |post|
      post.update_attributes!(:author_id => post.blog.user_id)
    end
  end

  def down
    remove_column :posts, :author_id
  end
end
