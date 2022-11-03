# frozen_string_literal: true

class Session
  class Window
    class Pane
      class Layout
        def initialize(**options)
          @options = options
        end

        def percent
          @percent ||= config.fetch(:percent, nil)
        end

        private

        def config
          @config ||= @options.fetch(:layout)
        end
      end
    end
  end
end
