class User < ApplicationRecord
  has_secure_password
  has_many :baskets
  has_many :line_items
  has_many :products, through: :line_items
end
