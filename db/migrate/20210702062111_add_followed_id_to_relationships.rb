class AddFollowedIdToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :followed_id, :integer
    t.references :user, foreign_key: true
    t.references :follow, foreign_key: { to_table: :users }

    t.timestamps

    t.index [:follower_id, :followed_id], unique: true
  end
end
