class CategoriesController < ApplicationController

  def index
    @categories = Category.includes(:picture)
  end

  def products
    @products = Category.find(params[:id]).products.includes(:picture)
    render 'products/index'
  end
end
