class AddPostAccessToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :post_access, :string, :default => [].to_yaml
  end
end
