class AddNumberToPost < ActiveRecord::Migration
  def up
    add_column :posts, :number, :integer
    # #Assign number to existing posts
    # Blog.find_each do |blog|
    #   number = 1
    #   blog.posts.where(draft: false).order("published_at ASC").each do |post|
    #     post.update_attributes!(number: number)
    #     number += 1
    #   end
    # end
  end

  def down
    remove_column :posts, :number
  end
end
