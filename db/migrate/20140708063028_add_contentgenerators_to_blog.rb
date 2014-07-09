class AddContentgeneratorsToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :content_generators, :string, :default => [].to_yaml
  end
end
