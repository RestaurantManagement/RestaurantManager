class User < ApplicationRecord
	#relations:
	has_one :temp_order, dependent: :destroy
	has_many :orders, dependent: :destroy
	#
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	
	validates :email, presence: true, length: { maximum: 50 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	#like clause
	def self.match_scope_condition(col, query)
		arel_table[col].matches("%#{query}%")
	end
	##
	scope :matching, lambda {|*args|
		col, opts = args.shift, args.extract_options!
		op = opts[:operator] || :or
		where args.flatten.map {|query| match_scope_condition(col, query) }.inject(&op)
	}

end
