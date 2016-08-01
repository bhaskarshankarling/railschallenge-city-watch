module EmergencyHandler
  class Procedure < EmergencyHandler::Base
    attr_reader :responder_names, :full_response

    def initialize(emergency)
      @emergency = emergency
      @is_very_sever = true
      @is_resource_sufficient = true
      @responder_names = []
      @responder_references = []
    end

    def dispatch_responders
      severeties.each do |severity_type, severity_level|
        responder = EmergencyHandler::Responder.new(titelize(severity_type), severity_level)
        responder.process_responders
        @responder_names += responder.names
        @responder_references += responder.references
        @is_very_sever &= responder.very_sever?
        @is_resource_sufficient &= responder.resource_sufficient?
      end
      mark_emeregency_as_served
      set_full_response
      nil
    end

    private

    def mark_emeregency_as_served
      @emergency.update_attributes(is_served: true, responder_ids: @responder_references) if @is_resource_sufficient
    end

    def set_full_response
      @full_response = [
        Emergency.where(is_served: true).count,
        Emergency.count
      ] unless @is_very_sever
    end

    def titelize(severity_type)
      severity_type.scan(/(\w+)_severity/).first.first.capitalize
    end
  end
end
