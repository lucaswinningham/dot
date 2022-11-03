# frozen_string_literal: true

require 'serialization'

require_relative 'meta/logger'

module Build
  class Meta
    include Serialization

    readable(:logger, default: {}, loads: ->(logger) { Logger.new logger })
  end
end
