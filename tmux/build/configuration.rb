# frozen_string_literal: true

require 'serialization'

require_relative 'meta'
require_relative 'session'

module Build
  class Configuration
    include Serialization

    readable(:meta, default: {}, loads: ->(meta) { Meta.new meta })
    readable(:session, default: {}, loads: ->(session) { Session.new session })
  end
end
