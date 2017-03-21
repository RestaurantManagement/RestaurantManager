class InfoStaff < ApplicationRecord
  belongs_to :Staff
  default_scope -> 	{order(created_at: :desc)}

  validates :Staff_id , presence: true
  validates :name,presence: true,length: {maximum:30}
  validates_numericality_of :age,  only_integer: true, greater_than: 0
  validates :description,length: {maximum: 100}
  validates :nation,presence: true,length: {maximum:30}
  mount_uploader :image, ImageUploader
end
