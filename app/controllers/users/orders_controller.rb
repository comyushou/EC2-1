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
	def 
		
	end

	def confirm
	end

	def complete
	end


end
