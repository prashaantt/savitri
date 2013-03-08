class CreateStanzas < ActiveRecord::Migration
  
  def self.up
    create_table :stanzas do |t|
      t.integer :no, :null => false
  	  t.references :section
    
      t.timestamps
    end
  end

  def self.down
  	drop_table :stanzas
  end
end
