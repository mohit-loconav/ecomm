class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
    if params[:category_id]
      category = Category.find(params[:category_id])
      @products = category.products.includes(:picture)
      title = category.name
    else
      @products = Product.includes(:picture).all
      title = "Products"
    end
    render 'index', locals: {title: title}
  end

  def show
    @product = Product.where(id: params[:id]).includes(:picture)[0]
  end
end
