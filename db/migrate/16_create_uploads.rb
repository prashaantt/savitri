class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :post
      t.string :photo

      t.timestamps
    end
  end
end
