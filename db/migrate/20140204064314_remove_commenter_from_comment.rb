class RemoveCommenterFromComment < ActiveRecord::Migration
  def up
    remove_column :comments, :commenter
  end

  def down
    add_column :comments, :commenter, :string
  end
end
