class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :menu_items, [:category_id, :created_at]
  end
end
