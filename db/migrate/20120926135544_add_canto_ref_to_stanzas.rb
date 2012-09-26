class AddCantoRefToStanzas < ActiveRecord::Migration
  def change
  	change_table :stanzas do |t|
  		t.references :canto
  	end
  end
end
