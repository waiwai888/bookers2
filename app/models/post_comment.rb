class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  def show
    @book = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
end
