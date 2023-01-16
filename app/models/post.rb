class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :content, presence: true, length: { maximum: 140 }
  validates :image, presence: true

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
