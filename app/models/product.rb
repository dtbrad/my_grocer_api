class Product < ApplicationRecord
  has_many :line_items
  has_many :users, through: :line_items
  has_many :baskets
  has_many :display_names

end
