# frozen_string_literal: true

require 'serialization'

require_relative 'window_definition'

module Build
  class Windows
    include Serialization

    readable(
      :definitions,
      default: [],
      loads: lambda { |defs| defs.map { |window_def| WindowDefinition.new window_def } }
    )

    def session_id=(session_id)
      definitions.each { |definition| definition.session_id = session_id }
    end

    def build
      definitions.each(&:create)

      threads = definitions.map { |definition| Thread.new { definition.build } }
      threads.each(&:join)
    end

    def default
      @default ||= definitions.find(&:default) || definitions[0]
    end
  end
end
