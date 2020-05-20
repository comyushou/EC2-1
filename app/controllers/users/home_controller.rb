class Users::HomeController < ApplicationController
	def top
		@genres = Genre.all
	end
end
