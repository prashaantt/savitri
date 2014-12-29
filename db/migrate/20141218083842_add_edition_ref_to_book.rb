class AddEditionRefToBook < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.references :edition, index: true
    end
  end
  def down
    change_table :books do |t|
      t.remove :edition_id
    end
  end
end
