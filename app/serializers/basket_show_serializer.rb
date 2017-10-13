class BasketShowSerializer < ActiveModel::Serializer
  attributes :id, :transaction_date, :total_cents, :line_item_count
  has_many :line_items
end
