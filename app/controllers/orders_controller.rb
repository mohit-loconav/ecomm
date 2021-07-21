class OrdersController < ApplicationController
  before_action :check_cart, only: [:new, :create]

  def new
    @delivery_detail = DeliveryDetail.new
  end

  def create
    @delivery_detail = current_user.delivery_details.create(delivery_detail_params)
    if @delivery_detail
      cart_items = current_user.current_items
      total = cart_items.inject(0) { |total, item| total+item.product.price }
      order = current_user.orders.create(delivery_detail_id: @delivery_detail.id, total: total)
      cart_items.update_all(order_id: order.id)
      flash[:success] = "Order placed"
      redirect_to root_url
    else
      render "new"
    end
  end

  def delivery_detail_params
    params.require(:delivery_detail).permit(:address, :phone_no)
  end

  private def check_cart
    if current_user.cart_items.empty?
      flash[:danger] = "Cart is empty"
      redirect_to category_path
    end
  end
end
