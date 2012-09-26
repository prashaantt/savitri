class CreateStanzas < ActiveRecord::Migration
  def change
    create_table :stanzas do |t|
      t.integer :stanzno

      t.timestamps
    end
  end
end
