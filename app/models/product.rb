class Product < ApplicationRecord
  has_many :products_categories
  has_many :categories, through: :products_categories
  has_one :picture, as: :imageable

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  before_save :capitalize_name
end
