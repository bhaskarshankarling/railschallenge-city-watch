module EmergencyHandler
  class Base
    attr_reader :emergency

    def very_sever?
      @is_very_sever
    end

    def resource_sufficient?
      @is_resource_sufficient
    end

    private

    def severeties
      @emergency.attributes.slice('fire_severity', 'medical_severity', 'police_severity')
    end
  end
end
