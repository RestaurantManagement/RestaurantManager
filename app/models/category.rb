class Category < ApplicationRecord
	has_many :menu_items, dependent: :destroy
	validates :content, presence: true, length: { maximum: 50 }

	mount_uploader :image, ImageUploader
end
