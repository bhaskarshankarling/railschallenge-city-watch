module EmergencyHandler
	class Base
		attr_reader :emergency

			def is_very_sever?
				@is_very_sever
			end

			def is_resource_sufficient?
				@is_resource_sufficient
			end
			
		private

			def severeties
				@emergency.attributes.slice('fire_severity', 'medical_severity', 'police_severity')
			end

	end
end