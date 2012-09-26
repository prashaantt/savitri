class AddStannoToLines < ActiveRecord::Migration
  def change
    add_column :lines, :stanzno, :integer
  end
end
