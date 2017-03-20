class Table < ApplicationRecord
	#relations:
	has_many :temp_orders
	has_many :orders
	#validates:
	validates :no, uniqueness: true
	validates_numericality_of :no,  only_integer: true, greater_than: 0

end
