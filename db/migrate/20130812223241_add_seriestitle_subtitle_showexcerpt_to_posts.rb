class AddSeriestitleSubtitleShowexcerptToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :series_title, :string
    add_column :posts, :subtitle, :string
    add_column :posts, :show_excerpt, :string
  end
end
