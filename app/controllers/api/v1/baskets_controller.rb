class Api::V1::BasketsController < ApiController
  skip_before_action :authenticate_token!

  def index
    user = set_user
    baskets = user.baskets.within_date_range(params).custom_sort(params)
    paginate json: baskets, each_serializer: BasketIndexSerializer
  end

  def spending_history
    user = set_user
    spending = Basket.group_baskets(user, params)
    render json: spending
  end

  def show
    user = set_user
    basket = Basket.find_by(id: params[:id])
    if basket && basket.user == user
      render json: basket, serializer: BasketShowSerializer
    else
      render status: 400, json: { message: ["You may only view your own shopping trips"] }
    end
  end

  private

  def set_user
    if auth_token
      authenticate_token!
      current_user
    else
      User.first
    end
  end
end
