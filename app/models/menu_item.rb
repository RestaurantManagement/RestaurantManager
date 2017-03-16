class MenuItem < ApplicationRecord
  belongs_to :category
  default_scope -> { order(created_at: :desc) }
  #validates attributes
  validates :category_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates_numericality_of :price,  only_integer: true, greater_than: 0
  validates :description, length: { maximum: 500 }
  #
  mount_uploader :image, ImageUploader
end
