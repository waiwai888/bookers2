class RemovePostImageFromPostComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_comments, :post_image, :integer
  end
end
