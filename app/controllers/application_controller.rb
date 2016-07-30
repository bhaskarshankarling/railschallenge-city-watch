class ApplicationController < ActionController::Base
	rescue_from ActionController::RoutingError, with: :send_404_response
	rescue_from ActiveRecord::UnknownAttributeError, with: :send_unknown_attribute_error

	private

		def send_404_response
			render json: { 'message' => 'page not found' }, status: 404
		end

		def send_unknown_attribute_error(exception)
			render json: { 'message' => 'found unpermitted parameter: resolved_at' }, status: 422
		end
end