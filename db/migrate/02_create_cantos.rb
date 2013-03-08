class CreateCantos < ActiveRecord::Migration
 
  def change
    create_table :cantos do |t|
      t.integer :no, :null => false
      t.string :title
      t.string :description
	  t.references :book
     
      t.timestamps
    end
  end

  def self.down
  	drop_table :cantos
  end

end
