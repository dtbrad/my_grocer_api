class Api::V1::ProductsController < ApiController
  before_action :authenticate_token

  def index
    products = @current_user.products.filtered_products.custom_sort(params)
    paginate json: products, option_name: @current_user
  end

  def total_spent
    products = @current_user.products.most_money_spent
    render json: products
  end

  def show
    product = Product.find(params[:productId])
    line_items = product.line_items.where("line_items.user_id = ?", @current_user.id).custom_sort(params)
    paginate json: line_items
  end

  def spending_chart
    product = Product.find(params[:productId])
    spending = product.line_items.where(user_id: @current_user.id).group_line_items(@current_user, params)
    render json: spending
  end
end
