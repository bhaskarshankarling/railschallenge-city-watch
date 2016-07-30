class ErrorsController < ApplicationController

	def raise_404_not_found
		raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
	end

end
