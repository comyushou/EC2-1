class Users::OrdersController < ApplicationController

	def new
		@order = Order.new
	end

	def create
	end

	def index
		@orders = current_user.orders.reverse
	end

	def show
	end

	def confirm
	end

	def complete
	end

end

