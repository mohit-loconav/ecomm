class Order < ApplicationRecord
  has_many :cart_items
  belongs_to :delivery_detail
end
