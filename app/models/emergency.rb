class Emergency < ActiveRecord::Base

	validates :code, uniqueness: true 
	validates_with PermitedAttributes, fields: [:id]
	
	class << self
		def create_emergency(params)
			attributes = params.reduce({}) do |attrs, (attribute, value)|
				if attribute.to_s.scan(/_severity/).present?
					attrs[attribute] = value.to_i
				else
					attrs[attribute] = value
				end
				attrs
			end
			new(attributes)
		end
	end
end
