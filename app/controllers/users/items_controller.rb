class Users::ItemsController < ApplicationController
	def index
		@items = Item.all
		@number = 0

		@genres = Genre.where(is_status: true) #ステータスが有効な複数のジャンルを呼び出し,商品が無効にできない
		@genres.each do |genre|
			items_total = genre.items.count
			@number += items_total
		end


		@genres = Genre.all


	end

	def show

		@item = Item.find(params[:id])
		#@genres = Genre.where(is_status: true) ＃使わないかも
		@cart = @item.cart_items.build
	end

	private
	def item_params
		params.require(:item).permit(:name, :price, :picture)

		@genres = Genre.all

	end


  end
end
