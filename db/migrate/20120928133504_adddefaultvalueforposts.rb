class Adddefaultvalueforposts < ActiveRecord::Migration
  def up
  	Post.connection.execute("update posts set user_id =\"1\"")
  end

  def down
  	Post.connection.execute("update posts set user_id=\"0\"")
  end
end
