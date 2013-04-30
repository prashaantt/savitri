class CreateBlogs < ActiveRecord::Migration
 
  def self.up
    create_table :blogs do |t|
      t.references :user
      t.string :title, :null => false
      t.string :subtitle
      t.string :slug, :null => false
 
      t.timestamps
    end
  end

  def self.down
  	drop_table :blogs
  end
  
end
