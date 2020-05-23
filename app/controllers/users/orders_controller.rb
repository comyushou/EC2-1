class Users::OrdersController < ApplicationController
	before_action :authenticate_user!

	def new
		@order = Order.new
		@new_address = Address.new
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
		@order = current_user.carts
		
	end

	def complete
	end

	private
	def order_params
		params.require(:order).permit(:user_id, :postage, :is_payment_method, :order_status, :review_name, :postal_code, :address, :billing_amount)
	end

end