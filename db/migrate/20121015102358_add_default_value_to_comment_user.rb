class AddDefaultValueToCommentUser < ActiveRecord::Migration
   def up
  	Comment.connection.execute("update comments set user_id =(select min(id) from users)")
  end

  def down
  	Comment.connection.execute("update comments set user_id=\"0\"")
  end
end
