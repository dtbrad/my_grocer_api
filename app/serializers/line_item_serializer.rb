class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :total_cents, :price_cents, :quantity, :weight, :discount_cents

  def product_name
    object.product.name
  end
end
