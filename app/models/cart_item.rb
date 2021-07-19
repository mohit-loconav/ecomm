class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product, -> { includes :picture }
end
