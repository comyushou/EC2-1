class Users::HomeController < ApplicationController
	def top
		@genres = Genre.all
		batch_size = 4
		@items = Item.where(is_sale_status: true)  #販売ステータスが有効になっているものだけ表示
        @itemitems = @items.offset(rand(@items.count-batch_size)).first(batch_size)


	end
	def about
	end
end

#ofset 指定した位置からレコードを取得 randランダム取得