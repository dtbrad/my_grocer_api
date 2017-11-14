class LineItem < ApplicationRecord
  belongs_to :basket
  belongs_to :product
  has_one :user

  def self.group_line_items(user, args = {})
    oldest_date = args.fetch(:oldest_date, user.baskets.order(:transaction_date).first.transaction_date.to_s)
    newest_date = args.fetch(:newest_date, user.baskets.order(:transaction_date).last.transaction_date.to_s)
    start_date = DateTime.parse(oldest_date)
    end_date = DateTime.parse(newest_date)
    unit = args.fetch(:unit, LineItem.pick_unit(start_date, end_date))
    data = group_by_period(unit, 'line_items.transaction_date', range: start_date..end_date).sum('line_items.quantity').to_a
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

  def self.custom_sort(args)
    category = args.fetch(:category, "sort_date")
    direction = args.fetch(:direction, "desc")
    direction = 'asc'.casecmp(direction).zero? ? 'asc' : 'desc'
    if category == "sort_date"
      send("sort_date", direction)
    else
      attribute_sort(category, direction)
    end
  end

  def self.sort_date(direction)
    order = ["baskets.transaction_date", direction].join(" ")
    joins(:basket).order(order)
  end

  def self.attribute_sort(attribute, direction)
    attribute = sanitize_sql(attribute)
    order(attribute + ' ' + direction)
  end

  def self.oldest
    order(:transaction_date).first
  end
end
