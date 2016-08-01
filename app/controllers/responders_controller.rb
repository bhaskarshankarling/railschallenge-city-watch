class RespondersController < ApplicationController

	def create
		Responder.create(responder_params)
		render json: { message: 'Responder created'}, status: 200
	end

	def update
		responder = Responder.where(name: params[:name]).first
		responder.update_on_duty_flag(params[:responder])
		render json: { message: 'Responder updated'}, status: 200
	end

	private

		def responder_params
			params.require(:responder).permit(:type, :name, :capacity)
		end

end
