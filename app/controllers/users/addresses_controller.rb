class Users::AddressesController < ApplicationController
	def index
		@address = Address.new
		@addresses = Address.all
	end
	def create
		@user = User.find(current_user.id)
		@address = Addres.new(address_params)
		@address.user_id = current_user.id
		if
			@address.save
			redirect_to request.referer #１つ前のURLに戻る
		end
	end

	def edit
		@address = Address.find(params[:id])
		if @address.user_id != current_user.id
			redirect_to users_addresses_path
		end

	end

	def update
		
	end
	def destroy
		
	end

	private
	def address_params
		params.require(:address).permit(:postal_code, :address, :name)
	end
end
