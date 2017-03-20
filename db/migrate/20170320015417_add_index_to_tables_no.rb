class AddIndexToTablesNo < ActiveRecord::Migration[5.0]
  def change
  	add_index :tables, :no, unique: true
  end
end
