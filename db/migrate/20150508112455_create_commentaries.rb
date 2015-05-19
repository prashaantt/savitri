class CreateCommentaries < ActiveRecord::Migration
  def change
    create_table :commentaries do |t|
      t.references :section
      t.hstore :data
      t.timestamps
    end
  end
end
