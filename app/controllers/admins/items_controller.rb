class Admins::ItemsController < ApplicationController

	def index
	end

	def new
		@item = Item.new
	end

	def create
		item = Item.new(item_params)
		item.save
		redirect_to request.referer
	end

	def show
		@item = Item.find(params[:id])
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		item = Item.find(params[:id])
		item.update(item_params)
		redirect_to request.referer
	end

	private
	def item_params
	  params.require(:item).permit(:genre_id,:name,:price,:picture,:is_sale_status,:description)
	end
end
