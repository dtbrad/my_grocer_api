class BasketSerializer < ActiveModel::Serializer
  attributes :id, :transaction_date, :total_cents
  has_many :line_items
end
