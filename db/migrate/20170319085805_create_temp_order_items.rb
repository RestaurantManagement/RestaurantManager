class CreateTempOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_order_items do |t|
      t.references :menu_item, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
