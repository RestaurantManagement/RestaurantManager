class TempOrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :temp_order
  #
  validates_numericality_of :quantity, only_integer: true, greater_than: 0
  #calculate the item price
  def price 
  	return self.menu_item.price * self.quantity
  end
end
