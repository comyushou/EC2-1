class Users::AddressesController < ApplicationController
	before_action :authenticate_user! #ログインユーザーのみ
	before_action :set_user #ログインしてるユーザーを最初に表示

	def index
		@address = Address.new
		@addresses = @user.addresses.all
	end

	def create
		@address = Address.new(address_params)
		@address.user_id = current_user.id
		if @address.save
		   redirect_to request.referer #１つ前のURLに戻る
		else
			@addresses = Address.all
			render :index
		end
	end

	def edit
		@address = Address.find(params[:id])
		if @address.user_id != current_user.id
			redirect_to users_addresses_path
		end

	end

	def update
		@address = Address.find(params[:id])
		@address.update(address_params)
		redirect_to users_addresses_path
	end
	def destroy
		@address = Address.find(params[:id])
		@address.destroy
		redirect_to users_addresses_path
		
	end

	private
	def address_params
		params.require(:address).permit(:user_id, :postal_code, :address, :name)
	end

	def set_user
	  	@user = current_user
	end
end
