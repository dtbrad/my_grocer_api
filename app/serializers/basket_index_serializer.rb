class BasketIndexSerializer < ActiveModel::Serializer

  attributes :id, :transaction_date, :total_cents, :line_item_count

end
