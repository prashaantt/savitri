class ChangeRewritesVarcharToText < ActiveRecord::Migration
  def up
    change_column :rewrites, :source, :text, :limit => nil
    change_column :rewrites, :destination, :text, :limit => nil
  end

  def down
    change_column :rewrites, :source, :string
    change_column :rewrites, :destination, :string
  end
end
