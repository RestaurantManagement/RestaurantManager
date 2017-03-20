class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :order
  #
  validates_numericality_of :quantity, only_integer: true, greater_than: 0
  #calculate the item price
  def price 
  	return self.menu_item.price * self.quantity
  end

  #static method used for clone from temp
  def self.clone_temp(temp, id)
  	return false if temp.class != TempOrderItem
  	item =  OrderItem.create(menu_item_id: temp.menu_item_id, quantity: temp.quantity,
  													 order_id: id)
  	if item.class == OrderItem
  		return {flag: true, id: item.id} 
  	else
  		return false
  	end
  end

end
