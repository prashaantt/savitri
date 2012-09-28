class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      
      t.timestamps
    end
    
    change_table :posts do |t|
    	t.references :user
    end
  end
end
