class AddBookTimeToTempOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :temp_orders, :book_time, :datetime
  end
end
