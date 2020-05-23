class CreateStockItems < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end

    add_index :stock_items, [:product_id, :store_id], unique: true
  end
end
