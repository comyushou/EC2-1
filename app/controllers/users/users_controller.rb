class Users::UsersController < ApplicationController

	def show
		@user = current_user
	end

	def edit
	end

	def update
	end

	def user_params
		params.require(:user).permit(:family_name, :first_name, :kana_family_name, :kana_first_name, :postal_code, :phone_number, :address, )
	end
	def leave
	end

	def hide
	end

end
