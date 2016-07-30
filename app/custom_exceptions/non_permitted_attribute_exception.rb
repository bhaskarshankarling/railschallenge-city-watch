class NonPermittedAttributeException < StandardError
	attr_accessor :attribute

	def initialize(attribute)
		@attribute = attribute
		@message = "found unpermitted parameter: #{attribute}"
		super(@message)
	end
end