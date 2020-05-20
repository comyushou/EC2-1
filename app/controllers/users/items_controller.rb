class Users::ItemsController < ApplicationController
	def index
		@items = Item.all
		@number = 0
		@genres = Genre.all

	end

	def show
		@genres = Genre.all
	end


  end
end
