class Users::CartItemsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user
	before_action :total_price, only:[:index]


	def index
		@cart_items = @user.cart_items.all
	end

	def update
		@cart_item = CartItem.find(params[:id])   #非同期通信のfrom_withの時はredirectはいらない。
		@cart_item.update(cart_item_params)
		@item_price = @cart_item.item.price * 1.1

		total_price
	end

	def create
		@cart_item = CartItem.new(cart_item_params)
		@cart_item.user_id = current_user.id
		#@cart_items =  CartItem.find(params[:id]) #findの検索条件はidのみ、複数のidを取得出来る
		#@cart_items = CartItem.find_by(item_id: @cart_item.item_id,user_id: @cart_item.user_id)
		##find_byはnilを返すというデメリットがありid以外でも検索出来るが、取得できる値は、最初にマッチした１件のみ。   #binding.pry
		@cart_item.item_id = params[:item_id]
		@current_items = CartItem.find_by(item_id: @cart_item.item_id,user_id: @cart_item.user_id)
		if @current_items.blank? #空か存在しないか？
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

	def set_user
		@user = current_user
	end

	def total_price
		@cart_total = []  #配列作るもの
		current_user.cart_items.each do |cart_item|
			@cart_total.push(cart_item.item.price.to_i * cart_item.unit)
		end	
		@total = @cart_total.sum  #sumは配列のそれぞれの要素を足し合わせる
	end

		
end
