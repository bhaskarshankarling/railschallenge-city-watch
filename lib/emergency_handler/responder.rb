module EmergencyHandler
  class Responder < EmergencyHandler::Base
    attr_reader :names, :references

    def initialize(severity_type, severity_level)
      @severity_type = severity_type
      @severity_level = severity_level
      @names = []
      @is_very_sever = false
      @is_resource_sufficient = true
      @references = []
    end

    def process_responders
      if @severity_level < 99
        return if @severity_level.eql?(0)
        set_responders
      else
        @is_very_sever = true
        @is_resource_sufficient = false
        set_all_on_duty_reponders
      end
    end

    def set_all_on_duty_reponders
      @names = ::Responder.where(type: @severity_type, on_duty: true).pluck(:name)
    end

    def set_responders
      responder_count = 0
      availale_responders = ::Responder.where(
        'type = ? AND on_duty = ? AND emergency_id IS NULL',
        @severity_type,
        true
      ).order('capacity DESC').entries
      remaining_severity = @severity_level
      if availale_responders.present?
        availale_responders.each do |responder|
          if remaining_severity >= responder.capacity
            remaining_severity -= responder.capacity
            @names << responder.name
            @references << responder.id
            responder_count += 1
          end
          break if remaining_severity <= 0 || remaining_severity < responder.capacity
        end
        unless remaining_severity.eql?(0)
          availale_responders.shift(responder_count)
          availale_responders.reverse_each do |responder|
            if remaining_severity <= responder.capacity
              remaining_severity -= responder.capacity
              @references << responder.id
              @names << responder.name
            end
            break if remaining_severity <= 0 || remaining_severity < responder.capacity
          end
        end
      end
      @is_resource_sufficient = (remaining_severity <= 0)
    end
  end
end
