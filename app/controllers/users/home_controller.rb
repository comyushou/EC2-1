class Users::HomeController < ApplicationController
	def top
		@genres = Genre.all
		batch_size = 4
        @items = Item.offset(rand(Item.count-batch_size)).first(batch_size)
	end
	def about
	end
end
