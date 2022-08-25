# frozen_string_literal: true

module Yaso
  class Context
    attr_writer :success
    attr_reader :data

    def initialize(kwargs)
      @success = true
      @data = kwargs
    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      @data[key] = value
    end

    def to_h
      @data.dup
    end

    def success?
      @success
    end

    def failure?
      !@success
    end
  end
end
