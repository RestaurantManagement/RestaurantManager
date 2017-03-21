class Staff < ApplicationRecord
	has_many :info_staffs,dependent: :destroy 
	validates :content,presence:true,length:{maximum:20}

	mount_uploader 	:image,ImageUploader 
end
