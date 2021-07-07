class Message < ApplicationRecord
  alidates :content, presence: true
  belongs_to :room
  belongs_to :user
end
