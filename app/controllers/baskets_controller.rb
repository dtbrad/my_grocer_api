class BasketsController < ApplicationController

  def index
    date_ordered_baskets = Basket.within_date_range(params)
    custom_sorted_baskets = date_ordered_baskets.custom_sort(params[:category], params[:direction])
    oldest_date = date_ordered_baskets.last.transaction_date
    newest_date = date_ordered_baskets.first.transaction_date
    baskets_array = paginate custom_sorted_baskets
    render json: { baskets_array: { b: baskets_array, each_serializer: BasketSerializer }, dir: params[:direction] }
  end

  def spending_history
    spending = Basket.group_baskets(params)
    render json: spending
  end
end
