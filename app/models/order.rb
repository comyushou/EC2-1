class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items

  enum is_payment_method: {クレジットカード:0, 銀行振り込み:1}


  enum order_status: {入金待ち:0,入金確認:1,製作中:2,発送準備中:3,発送済み:4}
  #上下必要分の為、付け足しました。

#orderのorder_itemを抜き出したい為に定義
	def totalunit
	  totalunit = 0
	  self.order_items.each do |order_item|
	    totalunit += order_item.unit
	  end
	  totalunit
	end

end
