class ChangeVarcharToText < ActiveRecord::Migration
  def up
    change_column :notebooks, :line, :text, :limit => nil
    change_column :notebooks, :quote, :text, :limit => nil
    change_column :notebooks, :annotation, :text, :limit => nil
  end

  def down
    change_column :notebooks, :line, :string
    change_column :notebooks, :quote, :string
    change_column :notebooks, :annotation, :string
  end
end
