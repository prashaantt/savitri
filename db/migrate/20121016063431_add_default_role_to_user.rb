class AddDefaultRoleToUser < ActiveRecord::Migration
  def change
  	change_table :users do |t|
    	change_column :role_id, :default => 4
    end
  end
end
