class CartItemsController < ApplicationController

  def index
    @cart_items = current_user.current_items
  end

  def update
    cart_item = current_user.current_items([params[:id]])[0]
    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      current_user.current_items.create(product_id: params[:id], quantity: 1)
    end
    redirect_to cart_items_path
  end

  def destroy
    cart_item = current_user.current_items([params[:id]])[0]
    if cart_item
      cart_item.destroy
      redirect_to cart_items_path
    else
      flash[:danger] = "Invalid entry/not found"
      redirect_to cart_items_path
    end
  end
end
