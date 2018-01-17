class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found


	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [[:username],[:avatar],[:bio]])
    devise_parameter_sanitizer.permit(:account_update, keys: [[:username],[:avatar],[:bio]])
  end

  def not_found
    render html: "<strong>Sorry, we don't have that strain.</strong>".html_safe, status: 404
  end

end
