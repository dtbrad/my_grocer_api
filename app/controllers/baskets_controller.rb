class BasketsController < ApplicationController

  def index
    if params["just_a_unit_change"]
      chart_array = Basket.group_baskets(params)
    elsif params["just_a_resort"]
      date_ordered_baskets = Basket.within_date_range(params)
      custom_sorted_baskets = date_ordered_baskets.custom_sort(params[:category], params[:direction])
      oldest_date = date_ordered_baskets.last.transaction_date
      newest_date = date_ordered_baskets.first.transaction_date
      baskets_array = paginate custom_sorted_baskets
    elsif params["just_a_page_turn"]
      date_ordered_baskets = Basket.within_date_range(params)
      custom_sorted_baskets = date_ordered_baskets.custom_sort(params[:category], params[:direction])
      oldest_date = date_ordered_baskets.last.transaction_date
      newest_date = date_ordered_baskets.first.transaction_date
      baskets_array = paginate custom_sorted_baskets
    else
      date_ordered_baskets = Basket.within_date_range(params)
      custom_sorted_baskets = date_ordered_baskets.custom_sort(params[:category], params[:direction])
      oldest_date = date_ordered_baskets.last.transaction_date
      newest_date = date_ordered_baskets.first.transaction_date
      baskets_array = paginate custom_sorted_baskets
      chart_array = Basket.group_baskets(params)
    end
    render json: { baskets_array: { b: baskets_array, each_serializer: BasketSerializer }, chart_array: chart_array, oldest_date: oldest_date, newest_date: newest_date, dir: params[:direction] }
  end

  def spending_history
    spending = Basket.group_baskets(params)
    render json: spending
  end
end
