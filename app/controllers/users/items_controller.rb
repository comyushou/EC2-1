class Users::ItemsController < ApplicationController
	def index

		# indexのurlにジャンルidがある時を記述する
		if params[:genre_id]
			# @itemsは、ジャンルのジャンルidを引っ張って来る
			@items = Item.where(genre_id: params[:genre_id])
			@genres = Genre.all
			@number = @items.count
			# ジャンルnameを定義するため、ジャンルidを引っ張ってきて@genreに代入する。
			@genre = Genre.find(params[:genre_id])
			@name = @genre.name
		else
		# genre_idがない時は全表示
			@genres = Genre.all
			@items = Item.all
			@number = @items.count
			@name = "商品"

		end
	end

	def show

		@item = Item.find(params[:id])
		#@genres = Genre.where(is_status: true) ＃使わないかも
		@cart = @item.cart_items.build
		@genres = Genre.all
	end

	private
	def item_params
		params.require(:item).permit(:name, :price, :picture)
	end


end
