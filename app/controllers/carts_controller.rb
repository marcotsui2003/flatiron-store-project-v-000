class CartsController < ApplicationController

  def show
    @current_cart = Cart.find_by(id: params[:id])
  end

  def checkout
    @cart = Cart.find_by(id: params[:id])
    @cart.items.each do  |item|
      line_item = LineItem.find_by(item_id: item.id)
      item.inventory -= line_item.quantity
      item.save
    end
    @cart.update(status: "submitted")
    current_user.update(current_cart: nil)
    redirect_to cart_path(@cart)
  end

end
