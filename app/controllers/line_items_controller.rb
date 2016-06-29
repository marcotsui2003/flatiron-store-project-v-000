class LineItemsController < ApplicationController
  def create
    #need refactoring?

    #no need to consider when the user is not signed in , as the Add to Cart
    #buttons are hidden in such case
    @item = Item.find_by(id: params[:item_id])
    if current_user.current_cart.nil?
      @current_cart = current_user.create_current_cart
      current_user.save

    else
      @current_cart = current_user.current_cart
    end
    @current_cart.add_item(@item.id).save
    redirect_to cart_path(@current_cart)
  end

end
