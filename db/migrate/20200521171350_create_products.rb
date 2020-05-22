class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, unique: true
      t.string :manufactory, null: false
      t.float :cost_price, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :products, :deleted_at
  end
end
