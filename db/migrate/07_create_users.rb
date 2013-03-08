class CreateUsers < ActiveRecord::Migration
 
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :photo
	    t.references :role
 
      t.timestamps
    end
  end

  def self.down
  	drop_table :users
  end

end
