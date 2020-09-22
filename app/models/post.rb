class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :shop, presence: true, length: { maximum: 50 }
  validates :img, presence: true
  
  mount_uploader :img, ImgUploader
  
  has_many :favorites
  has_many :users, through: :favorites, dependent: :destroy
end
