class Responder < ActiveRecord::Base

	validates :name, uniqueness: true

	belongs_to :emergency
	
	self.inheritance_column = :inheritence

	def update_on_duty_flag(params)
		self.on_duty = params[:on_duty].eql?("true")
		self.save
	end

end