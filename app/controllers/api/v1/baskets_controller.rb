class Api::V1::BasketsController < ApiController
  before_action :authenticate_token

  def index
    baskets = @current_user.baskets.within_date_range(params).custom_sort(params)
    paginate json: baskets, each_serializer: BasketIndexSerializer
  end

  def spending_history
    spending = Basket.group_baskets(@current_user, params)
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
