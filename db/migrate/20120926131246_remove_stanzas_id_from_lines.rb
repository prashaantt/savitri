class RemoveStanzasIdFromLines < ActiveRecord::Migration
  def up
    remove_column :lines, :stanzas_id, :integer
    remove_column :lines, :stanzno, :integer
  
  end

  def down
  	add_column :lines, :stanzas_id, :integer
  	add_column :lines, :stanzno, :integer
  end
end
