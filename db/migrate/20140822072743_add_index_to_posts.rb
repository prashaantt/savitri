class AddIndexToPosts < ActiveRecord::Migration
  def change
    add_index(:posts, [:blog_id, :number], :unique => true)
  end
end
