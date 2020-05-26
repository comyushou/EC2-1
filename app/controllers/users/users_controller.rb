class Users::UsersController < ApplicationController
	before_action :authenticate_user!

	def show
		@user = current_user
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
			redirect_to users_mypage_path
		else
			render 'edit'
		end
	end

	def leave
	end

	def hide
		@user = current_user
		#is_activeカラムにフラグを立てる(defaultはtrue)
		@user.update(is_active: false)
		#ログアウトさせる
		reset_session
		redirect_to users_root_path
	end

	private

	def user_params
		params.require(:user).permit(:family_name, :first_name, :kana_family_name, :kana_first_name, :postal_code, :phone_number, :address, :email)
	end

end
