# frozen_string_literal: true

require 'serialization'

require_relative 'cmd/response'

module Build
  module Util
    class Cmd
      include Serialization

      required(:logger)

      def call(cmd)
        logger.info "`#{cmd}`"
        response = `#{cmd}`.chomp

        Response.new(response: response, success: $?.success?)
      end
    end
  end
end
