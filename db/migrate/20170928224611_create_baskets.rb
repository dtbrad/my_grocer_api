class CreateBaskets < ActiveRecord::Migration[5.0]
  def change
    create_table :baskets do |t|
      t.datetime :transaction_date
      t.integer :user_id
      t.integer :total_cents
      t.integer :tax_cents
      t.integer :subtotal_cents

      t.timestamps
    end
  end
end
