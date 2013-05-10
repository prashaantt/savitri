class AddMusicToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :music, :string
  end
end
