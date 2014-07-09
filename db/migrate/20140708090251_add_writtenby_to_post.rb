class AddWrittenbyToPost < ActiveRecord::Migration
  def change
    add_column :posts, :written_by, :integer
  end
end
