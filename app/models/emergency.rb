class Emergency < ActiveRecord::Base
  validates :code, uniqueness: true, presence: true
  validates :police_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fire_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :responders

  def update_emergency(params)
    update_attributes(Emergency.sanitized_params(params))
  end

  class << self
    def create_emergency(params)
      new(sanitized_params(params))
    end

    def sanitized_params(params)
      params.each_with_object({}) do |(attribute, value), attrs|
        if attribute.to_s.scan(/_severity/).present?
          attrs[attribute] = value.to_i
        else
          attrs[attribute] = value
        end
        attrs
      end
    end
  end
end
