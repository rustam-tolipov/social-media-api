class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true, length: { maximum: 140 }

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liked_comments, through: :likes, source: :likeable, source_type: 'Comment'
end
