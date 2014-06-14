class AddSoftDeleteToAll < ActiveRecord::Migration
  def up
    add_column :posts, :deleted_at, :datetime
    add_index :posts, :deleted_at

    add_column :comments, :deleted_at, :datetime
    add_index :comments, :deleted_at

    add_column :pages, :deleted_at, :datetime
    add_index :pages, :deleted_at

    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
  end

  def down
    remove_column :posts, :deleted_at
    remove_column :comments, :deleted_at
    remove_column :pages, :deleted_at
    remove_column :users, :deleted_at
  end
end
