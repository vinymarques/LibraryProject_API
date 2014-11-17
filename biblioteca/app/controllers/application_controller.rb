	class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :http_basic_authenticate
  skip_before_filter :verify_authenticity_token

	def http_basic_authenticate
	   if request.format == :json
	    	authenticate_or_request_with_http_basic do |email, password|
	       		@current_user = User.find_for_database_authentication(:email => URI.unescape(email))
	       		@current_user.present? ? @current_user.valid_password?(password) : false
	     	end
	   end
	end


  protected
 def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :nome, :endereco, :secret_p) }
   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:id, :password, :password_confirmation, :secret_p) }
 end
end
