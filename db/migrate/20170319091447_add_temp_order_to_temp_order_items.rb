class AddTempOrderToTempOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :temp_order_items, :temp_order, foreign_key: true
  end
end
