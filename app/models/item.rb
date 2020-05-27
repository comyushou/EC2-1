class Item < ApplicationRecord
	belongs_to :genre

	has_many :cart_items, dependent: :destroy
	has_many :order_items, dependent: :destroy

	attachment :picture

	validates :genre_id,:name,:price,:picture,:description, presence: true
	validates :is_sale_status, inclusion: { in: [true,false]}
	12345678.to_s(:delimited)

end

