class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items

  enum is_payment_method: {クレジットカード:0, 銀行振り込み:1}
end
