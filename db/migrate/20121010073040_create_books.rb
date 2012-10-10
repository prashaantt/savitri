class CreateBooks < ActiveRecord::Migration

  def change
    create_table :books do |t|
      t.integer :no
      t.string :name
      t.text :description

      t.timestamps
    end
  end

end