class PermitedAttributes < ActiveModel::Validator
	def validate(record)
		options[:fields].each do |field|		
	    if record.send(field).present?
	      record.errors[field] << "found unpermitted parameter: #{field}"
	    end
	  end
  end
end