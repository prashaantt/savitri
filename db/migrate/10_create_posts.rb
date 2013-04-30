class CreatePosts < ActiveRecord::Migration
 
  def self.up
    create_table :posts do |t|
      t.references :blog
      t.string :title, :null => false
      t.text :content
      t.text :md_content


      t.timestamps
    end
  end

  def self.down
  	drop_table :posts
  end

end
