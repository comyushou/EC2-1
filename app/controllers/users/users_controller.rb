class Users::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :screen_user, only: [:update, :edit]

	def show
		@user = current_user
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to users_mypage_path
		else
			render 'edit'
		end
	end

	def user_params
		params.require(:user).permit(:family_name, :first_name, :kana_family_name, :kana_first_name, :postal_code, :phone_number, :address, )
	end
	def leave
	end

	def hide
		@user = current_user
		@user.destroy
		redirect_to users_root_path
	end

	def screen_user
		if params[:id].to_i != current_user.id
		   redirect_to users_root_path
		end
	end

end
