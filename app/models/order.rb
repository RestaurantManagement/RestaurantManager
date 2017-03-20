class Order < ApplicationRecord
  #relations:
  belongs_to :user
  belongs_to :table
  has_many :order_items, dependent: :destroy

  #validates:
  validates :book_time, presence: true

  #calculate total prices of the order
  def total_price
  	result = 0;
  	items = self.order_items

  	items.each do |item|
  		result += item.price
  	end
  	return result
  end

  #static method used for clone from temp
  def self.clone_temp(temp) 
  	flag = true
  	return false if temp.class != TempOrder 

  	order = Order.create(user_id: temp.user_id, table_id: temp.table_id, book_time: temp.book_time)
		return false if order.class != Order

  	tmpId = []
  	temp.temp_order_items.each do |tmpItem|
  		item = OrderItem.clone_temp(tmpItem, order.id)
  		if !item
  			flag = false
  			break
  		else
  			tmpId.push(item[:id])
  		end
  	end

  	unless flag
  		tmpId.each do |id|
  			OrderItem.destroy(id)
  		end

  		Order.destroy(order.id)
  		return false
  	end

  	return order				
  end

end
