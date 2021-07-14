class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  has_many :view_counts, dependent: :destroy
  
  

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search, word)
    if search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
     @book = Book.all
    end
  end

end
