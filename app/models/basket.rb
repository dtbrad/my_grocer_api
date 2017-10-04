class Basket < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def self.within_date_range(args={})
    beginning = args.fetch(:beginning, '2014-01-01')
    finish = args.fetch(:finish, '2017-10-01')
    start_date = DateTime.parse(beginning)
    end_date = DateTime.parse(finish)
    Basket.where(transaction_date: start_date..end_date)
  end
end
