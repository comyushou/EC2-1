class Admins::TopController < ApplicationController

	def top
		# Time.zone.now.all_dayが本日を表し、whereで全件取得
		@orders = Order.where(created_at: Time.zone.now.all_day)
	end
end
