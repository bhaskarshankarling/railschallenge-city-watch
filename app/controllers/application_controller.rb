class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :send_404_response
  rescue_from ActionController::UnpermittedParameters, with: :send_unpermitted_parameters_error

  private

  def send_404_response
    render json: { message: 'page not found' }, status: 404
  end

  def send_unpermitted_parameters_error(exception)
    render json: { message: exception.message }, status: 422
  end
end
