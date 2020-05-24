class Users::CartItemsController < ApplicationController

	def index
		@number = 0
		@cart_items = current_user.cart_items.all
	end

	def update
		@cart_item = CartItem.find(params[:id])   #非同期通信のfrom_withの時はredirectはいらない。
		@cart_item.update(cart_item_params)
		redirect_to users_cart_items_path
	end

	def create
		@cart_item = CartItem.new(cart_item_params)
		@cart_item.user_id = current_user.id
		#@cart_items =  CartItem.find(params[:id])　#findの検索条件はidのみ、複数のidを取得出来る
		#@cart_items = CartItem.find_by(item_id: @cart_item.item_id,user_id: @cart_item.user_id)
		##find_byはnilを返すというデメリットがありid以外でも検索出来るが、取得できる値は、最初にマッチした１件のみ。   #binding.pry
		@cart_item.item_id = params[:item_id]
		@current_items = CartItem.find_by(item_id: @cart_item.item_id,user_id: @cart_item.user_id)
		if @current_items.blank?
			@cart_item.save
			redirect_to users_cart_items_path
		else
        	@current_items.unit += params[:cart_item][:unit].to_i
            @current_items.update(unit: @current_items.unit)
            redirect_to users_cart_items_path
		end

	end


	def destroy_part
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to users_cart_items_path
	end

	def destroy_cart #カート内全削除
		@cart_items = current_user.cart_items
		@cart_items.destroy_all
		redirect_to users_cart_items_path
	end

	private
	def cart_item_params
		params.require(:cart_item).permit(:item_id, :user_id, :unit)	
	end

		
end
