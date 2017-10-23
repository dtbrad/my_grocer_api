class Api::V1::BasketsController < ApplicationController
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
    basket = Basket.find(params[:id])
    render json: basket, serializer: BasketShowSerializer
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
