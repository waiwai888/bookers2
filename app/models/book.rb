class Book < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length:{ maximum: 200 }

end
