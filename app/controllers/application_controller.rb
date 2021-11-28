class ApplicationController < ActionController::Base
    
###追加記述。これはnameを登録できるよう追加したから書いてる。

    before_action :authenticate_user!,except: [:home, :about]
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    ### 部分テンプレートで使用するために書いている。
    def after_sign_in_path_for(resource)
        user_path(current_user.id)
    end
    
    private

    def configure_permitted_parameters
        added_attrs = [:user_name, :email, :password, :password_confirmation, :remember_me]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
    
end
