class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :total_cents, :price_cents, :quantity, :weight, :discount_cents, :transaction_date, :basket_id

  def product_name
    object.product.name
  end

  def basket_id
    object.basket.id
  end

end
