class Basket < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  paginates_per 10

  def self.custom_sort(args)
    category = args.fetch(:sortCategory, "sort_date")
    desc = args.fetch(:desc, "true")
    direction = desc == "true" ? 'desc' : 'asc'
    send(category, direction)
  end

  def self.sort_date(direction)
    order = ["baskets.transaction_date", direction].join(" ")
    order(order)
  end

  def self.sort_items(direction)
    order = ["baskets.line_item_count", direction].join(" ")
    order(order)
  end

  def self.sort_total(direction)
    order = ["baskets.total_cents", direction].join(" ")
    order(order)
  end

  def self.within_date_range(args = {})
    oldest_date = args.fetch(:oldestDate, order(:transaction_date).first.transaction_date.to_s)
    newest_date = args.fetch(:newestDate, order(:transaction_date).last.transaction_date.to_s)
    start_date = DateTime.parse(oldest_date)
    end_date = DateTime.parse(newest_date)
    where(transaction_date: start_date..end_date)
  end

  def self.group_baskets(args = {})
    oldest_date = args.fetch(:oldestDate, self.last.transaction_date.to_s)
    newest_date = args.fetch(:newestDate, self.first.transaction_date.to_s)
    start_date = DateTime.parse(oldest_date)
    end_date = DateTime.parse(newest_date)
    unit = args.fetch(:unit, Basket.pick_unit(start_date, end_date))
    data = self.group_by_period(unit, :transaction_date, range: start_date..end_date).sum('baskets.total_cents').to_a
    { data: data, unit: unit }
  end

  def self.pick_unit(start_date, end_date)
    if end_date - start_date < (15 / 1)
      "day"
    elsif end_date - start_date < (30 / 1)
      "week"
    else
      "month"
    end
  end
end
