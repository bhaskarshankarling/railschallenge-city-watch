class EmergenciesController < ApplicationController
  def index
    emergencies = {
      emergencies: Emergency.all.entries,
      full_responses: [
        Emergency.where(is_served: true).count,
        Emergency.count
      ]
    }
    render json: emergencies, status: 200
  end

  def show
    emergency = Emergency.where(code: params[:code]).first
    if emergency.present?
      response = { emergency: emergency }
      status = 200
    else
      response = {}
      status = 404
    end

    render json: response, status: status
  end

  def create
    emergency_handler_system = EmergencyHandler.init(emergency_create_params)
    emergency_handler_system.dispatch_responders
    render emergency_handler_system.response
  end

  def update
    emergency = Emergency.where(code: params[:code]).first
    if emergency.update_emergency(emergency_update_params)
      response = { emergency: emergency }
      status = 200
    else
      response = {}
      status = 404
    end

    render json: response, status: status
  end

  private

  def emergency_create_params
    params.require(:emergency).permit(:code, :police_severity, :fire_severity, :medical_severity)
  end

  def emergency_update_params
    params.require(:emergency).permit(:police_severity, :fire_severity, :medical_severity, :resolved_at)
  end
end
