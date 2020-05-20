class Admins::ItemsController < ApplicationController
before_action :authenticate_admin!
	def index
		@items = Item.all
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)
		@item.save
		redirect_to admins_item_path(@item.id)
	end

	def show
		@item = Item.find(params[:id])
		@zeikomi = (@item.price.to_i/10)+@item.price.to_i
	end
	#今回のpriceがstringなので、一度integerに変換して計算しています。
	#*1.1ではなく、/10にするのは整数同士の計算にする為です。
	#*1.1だと整数*少数点の計算になるので、計算結果が10.0のように小数点がついてしまいます。

	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		@item.update(item_params)
		redirect_to admins_item_path(@item.id)
	end

	private
	def item_params
	  params.require(:item).permit(:genre_id,:name,:price,:picture,:is_sale_status,:description)
	end
end
