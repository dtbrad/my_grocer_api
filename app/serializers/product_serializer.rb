class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :total_purchased, :lowest_price, :most_recently_puchased, :highest_price
  # def user
  #   @user ||= instance_options.first
  # end

  def total_purchased
    user = instance_options[:option_name]
    object.total_purchased_by_user(user)
  end

  def highest_price
    user = instance_options[:option_name]
    object.highest_price_by_user(user)
  end

  def lowest_price
    user = instance_options[:option_name]
    object.lowest_price_by_user(user)
  end

  def most_recently_puchased
    user = instance_options[:option_name]
    object.most_recently_puchased_by_user(user)
  end
end
