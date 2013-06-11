class AddParentToPages < ActiveRecord::Migration
  def change
    add_column :pages, :parent, :integer
    add_column :pages, :url, :string
  end
end
