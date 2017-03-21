class AddImageToStaffs < ActiveRecord::Migration[5.0]
  def change
    add_column :staffs, :image, :string
  end
end
