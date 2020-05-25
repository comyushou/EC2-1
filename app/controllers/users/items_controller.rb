class Users::ItemsController < ApplicationController
	def index
		# indexのurlにジャンルidがある時を記述する
		if params[:genre_id]
			# @itemsは、ジャンルのジャンルidを引っ張って来る
			@items = Item.where(genre_id: params[:genre_id], is_sale_status: true).page(params[:page]).reverse_order
			@genres = Genre.all
			@number = @items.count
			# ジャンルnameを定義するため、ジャンルidを引っ張ってきて@genreに代入する。
			@genre = Genre.find(params[:genre_id])
			@name = @genre.name
		else
		# genre_idがない時は全表示
			@genres = Genre.all
			@items = Item.where(is_sale_status: true).page(params[:page]).reverse_order  #販売ステータスが有効になっているものだけ表示
			@number = @items.count
			@name = "商品"

		end
	end

	def show
		@genres = Genre.all
		@item = Item.find(params[:id])
		@cart = @item.cart_items.build
	end

	private
	def item_params
		params.require(:item).permit(:name, :price, :picture)
	end


end


#メモ　なんでジャンルで分けるのか、紐づいているから、でも何で/showもだけど何でいちいち.allで持ってきてる？