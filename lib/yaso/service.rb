# frozen_string_literal: true

module Yaso
  class Service
    extend Stepable

    attr_writer :success

    def initialize(context)
      @context = context
      @success = true
    end

    def [](key)
      @context[key]
    end

    def []=(key, value)
      @context[key] = value
    end

    def success?
      @success
    end

    def failure?
      !@success
    end

    def to_h
      @context.dup
    end

    def inspect
      "Result:#{self.class} successful: #{@success}, context: #{@context}"
    end

    class << self
      def call(context = {})
        @entry ||= flow.call(self, steps)
        step = @entry
        instance = new(context)
        success = true
        step, success = step.call(context, instance) while step
        instance.success = success
        instance
      end

      def flow(name = nil)
        @flow ||= Logic::FLOWS[:classic] if self == Yaso::Service
        return @flow || Yaso::Service.flow if name.nil?

        @flow = Logic::FLOWS[name] || raise(UnknownFlowError.new(self, name))
      end
    end
  end
end
