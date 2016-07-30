class PermitedAttributes < ActiveModel::Validator
	def validate(record)
		options[:fields].each do |field|		
	    if record.send(field).present?
	    	raise NonPermittedAttributeException.new(field)
	    end
	  end
  end
end