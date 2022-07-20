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

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
