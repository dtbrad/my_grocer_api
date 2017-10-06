class BasketsController < ApplicationController

  def index
    baskets = Basket.within_date_range(params)
    first_date = baskets.last.transaction_date
    last_date = baskets.first.transaction_date
    baskets_array = paginate Basket.within_date_range(params)
    render json: { baskets_array: { b: baskets_array, each_serializer: BasketSerializer }, first_date: first_date, last_date: last_date }
  end

  def spending_history
    spending = Basket.group_baskets(params)
    render json: spending
  end
end
