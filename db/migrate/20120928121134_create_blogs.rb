class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.references :user
      t.string :title
      t.string :subtitle
      t.timestamps
    end
  end
end
