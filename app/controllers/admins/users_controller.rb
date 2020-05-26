class Admins::UsersController < ApplicationController
	before_action :authenticate_admin!
	def index
		@users = User.page(params[:page]).per(10)
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])


	end

	def update
		@user = User.find(params[:id])
		
		if @user.is_active == "true" #ステータスをtrueにしたら論理削除したものを復活させる
			@user.update(is_active: false) #無効にしたら論理削除
		else
			@user.update(is_active: true) #論理削除から元に戻す
		end
		@user.update(user_params)
		redirect_to	admins_user_path

	end

	private
	def user_params
		params.require(:user).permit(:family_name,:first_name,:kana_family_name,:kana_first_name,:postal_code,:address,:phone_number,:email,:is_active)
	end
end
