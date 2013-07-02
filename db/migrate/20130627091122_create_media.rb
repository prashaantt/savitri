class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.references :user 
      t.string :title
      t.string :subtitle
      t.text :summary
      t.string :image_url
      t.text :category
      t.string :language
      t.string :explicit
      t.string :block
      t.string :complete
      t.string :url

      t.timestamps
    end
  end
end
