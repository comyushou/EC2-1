class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!
	def index
		@orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
		@userorder = @order.order_items
	end

	def update
		order = Order.find(params[:id])
		order.update(order_params)
		redirect_to request.referer
	end

	private
	def order_params
    params.require(:order).permit(:user_id,:postage,:is_payment_method,:order_status,:review_name,:postal_code,:address,:billing_amount)
    end

end

