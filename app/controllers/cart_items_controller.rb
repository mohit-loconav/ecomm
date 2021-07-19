class CartItemsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    @cart_items = user.cart_items
  end

  def update
    user = User.find(params[:user_id])
    cart_item = user.cart_items.find_by(product_id: params[:id])
    if cart_item
      cart_item.quantity += 1
      cart_item.save
      puts "update"
    else
      user.cart_items.create(product_id: params[:id], quantity: 1)
      puts "new"
    end
    redirect_to user_cart_items_path
  end

  def destroy
    user = User.find(params[:user_id])
    cart_item = user.cart_items.where(product_id: params[:id])[0]
    if cart_item
      cart_item.destroy
      redirect_to user_cart_items_path
    else
      flash[:danger] = "Invalid entry/not found"
      redirect_to user_cart_items_path
    end
  end
end
