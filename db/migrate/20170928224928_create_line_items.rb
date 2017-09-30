class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :basket_id
      t.integer :user_id
      t.integer :quantity
      t.integer :discount_cents
      t.integer :price_cents
      t.decimal :weight
      t.datetime :transaction_date

      t.timestamps
    end
  end
end
