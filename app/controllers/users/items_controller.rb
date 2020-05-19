class Users::ItemsController < ApplicationController
	def index
		@items = Item.all
		@number = 0
	end

	def show
	end
end
