# Adding position to maintain custom position of blogs
class AddPositionToBlog < ActiveRecord::Migration
  def self.up
    execute 'CREATE SEQUENCE blogs_position_seq;'
    add_column :blogs, :position, :integer, unsigned: true, unique: true
    execute "ALTER TABLE blogs ALTER COLUMN position SET DEFAULT NEXTVAL('blogs_position_seq'::regclass);"
    # Blog.find_by_slug('savitri-cultural').update_attributes!(position: 1)
    # Blog.find_by_slug('light-of-supreme').update_attributes!(position: 2)
    # Blog.find_by_slug('parasya-jyotih').update_attributes!(position: 3)
    execute 'ALTER SEQUENCE blogs_position_seq OWNED BY blogs.position;'
    change_column :blogs, :position, :integer, null: false
  end

  def self.down
    remove_column :blogs, :position
    execute 'DROP SEQUENCE  IF EXISTS blogs_position_seq CASCADE;'
  end
end
