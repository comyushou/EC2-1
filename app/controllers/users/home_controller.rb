class Users::HomeController < ApplicationController
	def top
		@genres = Genre.all
		@items = Item.offset(rand(Item.count)).first(4)
	end
	def about
	end
end
