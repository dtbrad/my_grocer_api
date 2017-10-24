class Api::V1::ProductsController < ApiController
  skip_before_action :authenticate_token!
  def index
    products = Product.all
    response.headers["item_count"] = products.count
    paginate json: products
  end
end
