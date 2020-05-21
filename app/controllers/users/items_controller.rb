class Users::ItemsController < ApplicationController
	def index

		@items = Item.all
		@number = 0

		@genres = Genre.where(is_status: true) #ステータスが有効な複数のジャンルを呼び出し,商品が無効にできない
		@genres.each do |genre|
			items_total = genre.items.count #有効商品が何個あるかを出すための定義
			@number += items_total
		end


		@genres = Genre.all



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
		@genres = Genre.all
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
