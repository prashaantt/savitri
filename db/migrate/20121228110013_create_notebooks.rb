class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :line
      t.string :quote
      t.string :annotation
      t.string :start
      t.integer :startoffset
      t.string :end
      t.integer :endoffset
      t.string :externalurl
      t.string   :uri
      t.references :line
      t.references :user
      t.timestamps
    end
  end
end
