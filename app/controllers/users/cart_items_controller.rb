class Users::CartItemsController < ApplicationController

	def index
		
	end

	def update
	end

	def create
	end


	def destroy_part
		@cart_item.destroy
		redirect_to cart_items_path
	end

	def destroy_cart　#カート内全削除
		@user.cart_item.destroy_all
		redirect_to cart_items_path
	end
		
end
