class AddStanzaRefToLines < ActiveRecord::Migration
  def change
  	change_table :lines do |t|
  		t.references :stanza
  	end
  end
end
