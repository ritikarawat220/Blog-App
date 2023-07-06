class RemoveUserIdFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :user_id, :integer
  end
end
