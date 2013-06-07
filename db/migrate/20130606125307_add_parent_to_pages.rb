class AddParentToPages < ActiveRecord::Migration
  def change
    add_column :pages, :parent, :integer
  end
end
