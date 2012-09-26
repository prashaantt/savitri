class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :line
      t.integer :no

      t.timestamps
    end
  end
end
