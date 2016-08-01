class ErrorsController < ApplicationController
  def raise_404_not_found
    fail ActionController::RoutingError, "No route matches #{params[:unmatched_route]}"
  end
end
