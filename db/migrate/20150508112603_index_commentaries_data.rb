class IndexCommentariesData < ActiveRecord::Migration
  def up
    execute 'CREATE INDEX commentaries_data ON commentaries USING GIN(data)'
  end

  def down
    execute 'DROP INDEX commentaries_data'
  end
end
