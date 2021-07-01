class AddBookIdToPostComments < ActiveRecord::Migration[5.2]
  def change
    add_column :post_comments, :book_id, :string
  end
end
