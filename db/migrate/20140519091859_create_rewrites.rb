class CreateRewrites < ActiveRecord::Migration
  def change
    create_table :rewrites do |t|
      t.string :source
      t.string :destination
      t.integer :code

      t.timestamps
    end
  end
end
