class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
    def after_sign_up_path_for(resource)
      users_root_path
    end

    def after_sign_in_path_for(resource)
      users_root_path
    end

    def after_sign_out_path_for(resource)
      users_root_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:family_name, :first_name, :kana_family_name, :kana_first_name, :postal_code, :address, :phone_number, :password])
    end


end
