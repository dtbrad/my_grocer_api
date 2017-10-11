class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    response.headers["item_count"] = products.count
    paginate json: products
  end
end
