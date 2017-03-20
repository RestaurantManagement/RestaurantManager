class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :tables do |t|
      t.integer :no
      t.boolean :beingUsed?

      t.timestamps
    end
  end
end
