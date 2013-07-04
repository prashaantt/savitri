class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.references :medium 
      t.string :title
      t.string :audio_url
      t.text :summary
      t.string :author
      t.integer :seconds
      t.integer :file_size
      t.string :url
      t.string :explicit
      t.integer :order
      t.string :closedcaptioned
      t.string :block

      t.timestamps
    end
  end
end
