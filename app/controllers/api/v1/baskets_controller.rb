class Api::V1::BasketsController < ApiController
  before_action :authenticate_token

  def index
    baskets = @current_user.baskets.within_date_range(params).custom_sort(params)
    # client only needs below if it didn't provide them in arguments
    unless (params["newestDate"] || params["oldestDate"])
      response.headers["newestDate"] = baskets.reorder(transaction_date: :desc).first.transaction_date.to_s
      response.headers["oldestDate"] = baskets.reorder(transaction_date: :desc).last.transaction_date.to_s
    end
    paginate json: baskets, each_serializer: BasketIndexSerializer
  end

  def spending_chart
    spending = @current_user.baskets.group_baskets(params)
    render json: spending
  end

  def show
    basket = Basket.find_by(id: params[:id])
    if basket && basket.user == @current_user
      render json: basket, serializer: BasketShowSerializer
    else
      render status: 400, json: { message: ["You may only view your own shopping trips"] }
    end
  end
end
