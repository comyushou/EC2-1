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
		@order = current_user.carts
		
	end

	def complete
	end

	private

end