class DeliveryDetail < ApplicationRecord
  validates :address, presence: true
  validates :phone_no, presence: true
end
