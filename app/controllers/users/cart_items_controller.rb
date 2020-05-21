class Users::CartItemsController < ApplicationController

	def index
		@cart_items = @user.cart_items.all
	end

	def update
	end

	def create
		@cart_item = CartItem.new(cart_item_params)
		@cart_item.user_id = current_user
		@current_item = CartItem.find_by(item_id: @cart_item.item_id,user_id: @cart_item.user_id)
		redirect_to users_cart_items_path
	end


	def destroy_part
		@cart_item.destroy
		redirect_to cart_items_path
	end

	def destroy_cart　#カート内全削除
		@user.cart_item.destroy_all
		redirect_to cart_items_path
	end

	private
	def cart_item_params
		params.require(:cart_item).permit(:item_id, :user_id, :unit)
		
	end
		
end
