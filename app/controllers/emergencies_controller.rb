class EmergenciesController < ApplicationController
	before_filter :check_severity_validity, only: :create
	
	def create
		emergency = Emergency.create_emergency(params[:emergency])
		if emergency.save
			response = {
				emergency: {
					code: params[:emergency][:code],
					fire_severity: params[:emergency][:fire_severity].to_i,
					police_severity: params[:emergency][:police_severity].to_i,
					medical_severity: params[:emergency][:medical_severity].to_i
				}
			}
			status = 201
		else
			response = {
				message: emergency.errors.messages
			}
			status = 422
		end

		render json: response, status: status, body: { message: nil }
	end

	private

		def valid_severity?
			valid_severity_flag = true
			params[:emergency].each do |key, value|
				if value.eql?("-1")
					valid_severity_flag = false
					break
				end
			end
			valid_severity_flag
		end

		def check_severity_validity
			unless valid_severity?
				response = {
					message: {
						fire_severity: ['must be greater than or equal to 0'],
						police_severity: ['must be greater than or equal to 0'],
						medical_severity: ['must be greater than or equal to 0']
					}
				}

				render json: response, status: 422
			end
		end

end
