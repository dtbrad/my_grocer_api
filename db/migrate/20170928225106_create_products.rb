class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :display_name
      t.integer :real_unit_price_cents

      t.timestamps
    end
  end
end
