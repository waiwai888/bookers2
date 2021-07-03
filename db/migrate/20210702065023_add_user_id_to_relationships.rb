class AddUserIdToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :user_id, :inteder
  end
end
