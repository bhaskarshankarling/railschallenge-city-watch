module EmergencyHandler
  class System < EmergencyHandler::Base
    attr_reader :emergency_message, :response

    def initialize(emergency_message)
      @emergency_message = emergency_message
      set_skeleton_response
    end

    def create_emergency_message
      @emergency = Emergency.create_emergency(@emergency_message)
      @emergency.save ? continue_processing : set_error_response
    end

    alias_method :dispatch_responders, :create_emergency_message

    private

    def set_skeleton_response
      @response = {
        json: {},
        status: nil,
        body: nil
      }
    end

    def continue_processing
      create_emergency_procedure
      dispatch_emergency_responders
      set_response
    end

    def create_emergency_procedure
      @procedure = EmergencyHandler::Procedure.new(@emergency)
    end

    def dispatch_emergency_responders
      @procedure.dispatch_responders
    end

    def set_error_response
      @response[:json][:message] = @emergency.errors.messages
      @response[:status] = 422
    end

    def set_response
      @response[:json][:emergency] = {
        code: @emergency_message[:code],
        fire_severity: @emergency_message[:fire_severity].to_i,
        police_severity: @emergency_message[:police_severity].to_i,
        medical_severity: @emergency_message[:medical_severity].to_i,
        responders: @procedure.responder_names,
        full_response: @procedure.full_response
      }
      @response[:status] = 201
    end
  end
end
