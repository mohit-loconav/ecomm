class Category < ApplicationRecord
  has_many :products_categories
  has_many :products, through: :products_categories
  has_one :picture, as: :imageable

  validates :name, presence: true

  before_save :capitalize_name
end
