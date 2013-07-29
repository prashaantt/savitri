class AddScheduledPosts < ActiveRecord::Migration
  def up
 	  add_column :posts, :published_at, :datetime
 	  add_column :posts, :draft, :boolean, :default => true
  end

  def down
    remove_column :posts, :published_at
    remove_column :posts, :draft
  end
end
