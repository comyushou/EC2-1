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
  	    @order.save # < order.id == 4 user_id: current_user.id, postal_code: ...>

  	    # カートアイテムの中身をオーダーアイテムの中に入れてあげる必要があるため、カートアイテムをeachで回す。
  	    current_user.cart_items.each do |f|
		@order_item = OrderItem.new # < order_item item_id: ,order_id: ,production_sttus: ,..>

  	    # 1回目 f == < cart_item user_id: current_user.id,item_id: 3, >
  	    # 2回目 f == < cart_item user_id: current_user.id,item_id: 5, >
  	    @order_item.item_id = f.item_id # < order_item item_id: 3,order_id: ,production_sttus: ,..>
  	    @order_item.order_id = @order.id # < order_item item_id: 3,order_id: 4,production_sttus: "着手不可",..>
  	    @order_item.production_status = "着手不可"
  	    @order_item.unit = f.unit
  	    @order_item.price = f.item.price

  	    @order_item.save
  	    end

  	    @cart_items = current_user.cart_items
  	    @cart_items.destroy_all  #購入完了した時点でカートを空にする



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
		@order_item = OrderItem.new
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

