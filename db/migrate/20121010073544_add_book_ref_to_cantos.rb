class AddBookRefToCantos < ActiveRecord::Migration
  def change
  	 change_table :cantos do |t|
    	t.references :book, :default => 1
    end
  end
end
