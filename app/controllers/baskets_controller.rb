class BasketsController < ApplicationController

  def index
    ordered_baskets = Basket.within_date_range(params)
    custom_sorted_baskets = ordered_baskets.custom_sort(params[:category], params[:direction])
    oldest_date = ordered_baskets.last.transaction_date
    newest_date = ordered_baskets.first.transaction_date
    baskets_array = paginate custom_sorted_baskets
    chart_array = Basket.group_baskets(params)
    render json: { baskets_array: { b: baskets_array, each_serializer: BasketSerializer }, chart_array: chart_array, oldest_date: oldest_date, newest_date: newest_date, dir: params[:direction] }
  end

  def spending_history
    spending = Basket.group_baskets(params)
    render json: spending
  end
end
