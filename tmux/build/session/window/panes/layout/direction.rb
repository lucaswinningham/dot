# frozen_string_literal: true

class Session
  class Window
    class Panes
      class Layout
        module Direction
          VERTICAL = :v
          HORIZONTAL = :h
          MAP = { vertical: VERTICAL, horizontal: HORIZONTAL }.freeze

          class << self
            def parse(direction)
              MAP.fetch(direction.downcase.to_sym) { raise StandardError }
            rescue StandardError
              raise CannotParseDirection, direction
            end

            class CannotParseDirection < StandardError
              def initialize(direction)
                super <<~MSG
                  Cannot parse #{direction.inspect} to a panes layout direction.
                  Valid values are #{valid_values}.
                MSG
              end

              def valid_values
                MAP.keys.map { |key| "'#{value}'" }.join(', ')
              end
            end
          end
        end
      end
    end
  end
end
