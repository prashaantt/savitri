class AddFeaturedToStanza < ActiveRecord::Migration
  def change
    add_column :stanzas, :featured, :boolean, null: false, default: false
  end
end
