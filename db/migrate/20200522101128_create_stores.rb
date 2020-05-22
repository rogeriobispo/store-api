class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false, unique: true
      t.string :address, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :stores, :deleted_at
  end
end
