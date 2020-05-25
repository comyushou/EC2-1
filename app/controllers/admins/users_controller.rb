class Admins::UsersController < ApplicationController
	before_action :authenticate_admin!
	def index
		# with_deletedで論理削除されているものも表示できる。
		@users = User.with_deleted.page(params[:page]).per(10)
	end

	def show
		@user = User.with_deleted.find(params[:id])
	end

	def edit
		@user = User.with_deleted.find(params[:id])


	end

	def update
		@user = User.with_deleted.find(params[:id])
		@user.update(user_params)
		if @user.is_active == "true" #ステータスをtrueにしたら論理削除したものを復活させる
			@user.restore #論理削除から元に戻す
		else
			@user.destroy #無効にしたら論理削除
		end
		redirect_to	admins_user_path
	end

	private
	def user_params
		params.require(:user).permit(:family_name,:first_name,:kana_family_name,:kana_first_name,:postal_code,:address,:phone_number,:email,:is_active)
	end
end
