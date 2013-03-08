class CreateBooks < ActiveRecord::Migration

  def self.up
    create_table :books do |t|
      t.integer :no, :null => false
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
  	drop_table :books
  end

end