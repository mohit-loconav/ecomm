class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product, -> { includes :picture }
  belongs_to :order, optional: true
  scope :current, -> { where(order_id: nil) }
end
