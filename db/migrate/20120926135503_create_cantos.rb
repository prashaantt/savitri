class CreateCantos < ActiveRecord::Migration
  def change
    create_table :cantos do |t|
      t.integer :cantono
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
