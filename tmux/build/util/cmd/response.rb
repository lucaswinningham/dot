# frozen_string_literal: true

require 'delegate'

module Build
  module Util
    class Cmd
      class Response < SimpleDelegator
        def initialize(response:, success:)
          super response

          @success = success
        end

        def success?
          @success
        end
      end
    end
  end
end
