class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  belongs_to :user
  belongs_to :tag
  belongs_to :prefecture

  has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true
  validates :tag_id, presence: true
  validates :prefecture_id, presence: true

end
