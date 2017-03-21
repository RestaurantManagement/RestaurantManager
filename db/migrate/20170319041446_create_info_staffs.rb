class CreateInfoStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :info_staffs do |t|
      t.string :name
      t.integer :age
      t.string :nation
      t.text :description
      t.string :image
      t.references :Staff, foreign_key: true

      t.timestamps
    end
    add_index :info_staffs, [:staff_id,:created_at]
  end
end
