class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :comment, presence: true
end
