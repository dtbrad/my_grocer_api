class AddLineItemCountColumnToBaskets < ActiveRecord::Migration[5.0]
  def change
    add_column :baskets, :line_item_count, :integer
  end
end
