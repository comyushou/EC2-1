class Admins::OrderItemsController < ApplicationController
	before_action :authenticate_admin!
	def update
		order_item = OrderItem.find(params[:id])
		order = order_item.order #order_itemのアソシエーションデータのorder情報が欲しい、カラムの連動更新をしたいので定義
		order_item.update(order_item_params)
		if order_item.production_status == "製作中" #このカラムが製作中になれば、指定した他のカラムもupdateで更新させる
		   order.update(order_status: "製作中")
		end

		#全ての対象カラムが制作完了になった場合、連動カラムも変更(発送準備中)されるように設定する。
		#最初に注文数を数える変数countを定義して、次に1:N記述でeachを回す。(全表示はeachじゃないと表示できないから)
		#カラムが制作完了ならば1足されていく。その数字とeachで回った数が等しければ、全てカラムが制作完了になって条件を満たしているので更新される

		count = 0
		order.order_items.each do |orderorder|
			if orderorder.production_status == "制作完了"
			  count = count + 1
		    end
			if count == order.order_items.count
				order.update(order_status: "発送準備中")
			end
		end
		redirect_to request.referer
	end






	private
	def order_item_params
      params.require(:order_item).permit(:item_id,:order_id,:production_status,:unit,:price)
    end
end

