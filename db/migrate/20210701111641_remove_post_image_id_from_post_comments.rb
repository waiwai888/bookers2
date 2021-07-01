class RemovePostImageIdFromPostComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_comments, :post_image_id, :integer
  end
end
