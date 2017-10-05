class Basket < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def self.within_date_range(args={})
    beginning = args.fetch(:beginning, '2015-11-23')
    finish = args.fetch(:finish, '2017-10-01')
    start_date = DateTime.parse(beginning)
    end_date = DateTime.parse(finish)
    Basket.where(transaction_date: start_date..end_date)
  end

  def self.group_baskets(args={})
    beginning = args.fetch(:beginning, '2015-11-23')
    finish = args.fetch(:finish, '2017-10-01')
    start_date = DateTime.parse(beginning)
    end_date = DateTime.parse(finish)
    unit = Basket.pick_unit(start_date, end_date)
    data = group_by_period(unit, :transaction_date, range: start_date..end_date).sum('baskets.total_cents').to_a
    {data: data, unit: unit}
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
