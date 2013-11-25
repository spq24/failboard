class RemoveUserIdFromFails < ActiveRecord::Migration

  def down
  	remove_column :user_id, :fails
  end
end
