class Admins::OrderItemsController < ApplicationController
before_action :authenticate_admin!
	def update
		order_item = OrderItem.find(params[:id])
		order_item.update(order_item_params)
		redirect_to request.referer
	end

	private
	def order_item_params
      params.require(:order_item).permit(:item_id,:order_id,:production_status,:unit,:price)
    end
end

