class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?


    def after_sign_up_path_for(resource)
      users_root_path
    end

      # アドミンでサインインとユーザーでサインインの時の振り分け
    def after_sign_in_path_for(resource)
      case resource
       when Admin
         admins_top_path
       when User
          users_root_path
      end
    end

    def after_sign_out_path_for(resource)
      case resource
       when :admin
         admin_session_path
       when :user
         users_root_path
      end
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:family_name, :first_name, :kana_family_name, :kana_first_name, :postal_code, :address, :phone_number, :password])
    end


end
