class AuthenticationController < ApplicationController
	before_filter :http_basic_authenticate
	def authenticate
		@user = current_user
		respond_to do |format|
			format.json 
		end
	end
end