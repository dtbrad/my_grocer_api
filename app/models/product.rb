class Product < ApplicationRecord
  has_many :line_items
  has_many :users, through: :line_items
  has_many :baskets
  has_many :display_names

  def self.filtered_products
    Product.where.not(name: ['Beer Bottle Dep', 'Beer Deposit 30 C',
                             'Beer Deposit 60 C', '$5 Off $30 Offer',
                             '$10 Off Coupon', '25% Wine Discount',
                             'Bag Refund', 'Bag It Forward', '$5 Off $30 offer',
                             '$5 Off Coupon', 'Beer Deposit 30C', '$6 Off $40 Offer',
                             '$5 Off $35 Offer', '10% Discount', 'Pabst Blue Ribbn Discount',
                             'Free Reusable Bag'])
  end

  def self.custom_sort(args)
    category = args.fetch(:category, "sort_name")
    direction = args.fetch(:direction, "desc")
    direction = 'asc'.casecmp(direction).zero? ? 'asc' : 'desc'
    send(category, direction)
  end

  def self.sort_times_bought(direction)
    order = ["line_items_sum", direction].join(" ")
    select('products.*', 'SUM(line_items.quantity) as line_items_sum').group('products.id').order(order)
  end

  def self.sort_highest_price(direction)
    order = ["MAX(line_items.price_cents)", direction].join(" ")
    select('products.*', 'MAX(line_items.price_cents)').group('products.id').order(order)
  end

  def self.sort_lowest_price(direction)
    order = ["MIN(line_items.price_cents)", direction].join(" ")
    select('products.*', 'MIN(line_items.price_cents) as min_price').group('products.id').order(order)
  end

  def self.sort_most_recently_purchased(direction)
    order = ["MAX(line_items.transaction_date)", direction].join(" ")
    joins(:line_items).select('products.*', 'MAX(line_items.transaction_date)').group('products.id').order(order)
  end

  def self.sort_name(direction)
    order = ["name", direction].join(" ")
    group('products.id').order(order)
  end

  def self.most_money_spent
    filtered_products
      .group('products.id')
      .order('sum(line_items.total_cents) desc').limit(10)
      .pluck('products.name, sum(line_items.total_cents), products.id')
  end

  def self.most_purchased
    filtered_products
      .joins(:line_items)
      .group('products.id')
      .order('sum(line_items.quantity) desc').limit(10)
      .pluck('products.name, sum(line_items.quantity), products.id')
  end

  def highest_price_by_user(user)
    selection = line_items.where(user_id: user.id)
    return if selection.empty?
    selection.order(:price_cents).last.price_cents
  end

  def lowest_price_by_user(user)
    selection = line_items.where(user_id: user.id)
    return if selection.empty?
    selection.order(:price_cents).first.price_cents
  end

  def total_purchased_by_user(user)
    selection = line_items.where(user_id: user.id)
    return if selection.empty?
    selection.sum(:quantity)
  end

  def most_recently_puchased_by_user(user)
    selection = line_items.where(user_id: user.id)
    return if selection.empty?
    selection.order(:transaction_date).last.transaction_date
  end
end
