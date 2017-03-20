class TempOrder < ApplicationRecord
  #relations:
  belongs_to :user
  belongs_to :table
  has_many :temp_order_items, dependent: :destroy

  accepts_nested_attributes_for :temp_order_items
  #validates:
  validates :book_time, presence: true

  #calculate total prices of the order
  def total_price
  	result = 0;
  	items = self.temp_order_items

  	items.each do |item|
  		result += item.price
  	end
  	return result
  end
end	
