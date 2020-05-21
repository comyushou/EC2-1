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

	end

	private

	def order_params
		params.require(:order).permit(:postage, :is_payment_method, :order_status, :review_name, :postal_code, :address, :billing_amount)
	end

	private
	def 
		
	end

	def confirm
	end

	def complete
	end


end
