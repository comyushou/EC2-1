class Users::OrdersController < ApplicationController
	before_action :authenticate_user!

	def new
		@order = Order.new
		@new_address = Address.new
	end

	def create
		if current_user.orders.where(user_id: params[:order][:item_id]).empty?
		@order = Order.new(order_params)
		@order.user_id = current_user.id
  	    @order.save
	   else
		@order = current_user.orders.find_by(user_id:params[:order][:item_id])
		@order.update(unit: params[:order][:unit].to_i + @order.unit)
        end
        redirect_to users_orders_complete_path

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
		@order = Order.new
		@order.is_payment_method = params[:order][:is_payment_method]

	  if params[:select_button] == "user_address"
        @order.postal_code = current_user.postal_code
      	@order.address = current_user.address
      	@order.review_name = current_user.family_name + current_user.first_name
      end

      if  params[:select_button] == "addresses_address"
      	@address =  Address.find(params[:order][:user_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.review_name = @address.name
      end

      if  params[:select_button] == "new_user_address"
	  	@order.postal_code = params[:order][:address][:postal_code]
      	@order.address = params[:order][:address][:address]
      	@order.review_name = params[:order][:address][:name]
      end
        @select_button = params[:select_button]


	end


	def complete
	end

	private
	def order_params
		params.require(:order).permit(:user_id, :postage, :is_payment_method, :order_status, :review_name, :postal_code, :address, :billing_amount)
	end

end

