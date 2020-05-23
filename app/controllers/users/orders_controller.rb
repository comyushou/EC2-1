class Users::OrdersController < ApplicationController

	def new
		@order = Order.new
	end

	def create
		@order = Order.new()
		@order_item.price = @item.price
		@order_item.save
	end

	def index
		@orders = current_user.orders.reverse
	end

	def show
		@order = Order.find(params[:id])
	    @order_items = OrderItems.where(order_id: params[:id])
	end

	def confirm
		@cart_items = current_user.cart_items
	end

	private
	def order_params
		params.require(:order).permit(:user_id, :postage, :is_payment_method, :order_status, :review_name, :postal_code, :address, :billing_amount)
	end



	def complete
	end

end