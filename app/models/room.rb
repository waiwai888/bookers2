class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :content, presence: true,
                      length: { maximum: 140}
end
