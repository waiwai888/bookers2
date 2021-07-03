class AddFollowIdToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :follow_id, :inteder
  end
end
