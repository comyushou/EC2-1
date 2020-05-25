class Users::HomeController < ApplicationController
	def top
		@genres = Genre.all
		batch_size = 4
        @items = Item.offset(rand(Item.count-batch_size)).first(batch_size)
	end
	def about
	end
end

#ofset 指定した位置からレコードを取得 randランダム取得