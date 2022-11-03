#!/usr/bin/env ruby

require 'serialization'

module Build
  class Panes
    class Layout
      include Serialization

      readable(:definitions, default: [])

      readable(
        :direction,
        default: :vertical,
        loads: ->(direction) { Direction.parse direction }
      )

      def direction
        @direction ||= Direction.parse config.fetch(:direction, Direction::VERTICAL)
      end

      def pane_percents(pane:, percent_used:)
        pane_layout_percent = pane.layout.percent || default_pane_layout_percent
        screen_percent = [((pane_layout_percent / max_percent.to_f) * 100).to_i, 100].min
        remaining_percent = 100 - percent_used
        split_window = (100 * (1 - (screen_percent / remaining_percent.to_f))).to_i

        { used: screen_percent, split_window: split_window }
      end

      private

      def max_percent
        @max_percent ||= [total_explicitly_allocated_pane_percentage, 100].max
      end

      def default_pane_layout_percent
        @default_pane_layout_percent ||= (
          (max_percent - total_explicitly_allocated_pane_percentage) /
            (definitions.count - explicitly_allocated_definitions.count)
        )
      end

      def explicitly_allocated_definitions
        @explicitly_allocated_definitions ||= definitions.filter { |pane| pane.layout.percent }
      end

      def total_explicitly_allocated_pane_percentage
        @total_explicitly_allocated_pane_percentage ||=
          explicitly_allocated_definitions.map(&:layout).map(&:percent).sum
      end

      module Direction
        class Error < StandardError; end
        class InvalidDirection < Error; end

        VERTICAL = 'vertical'
        HORIZONTAL = 'horizontal'
        MAP = { vertical: VERTICAL, horizontal: HORIZONTAL }.freeze

        class << self
          def parse(direction)
            MAP.fetch(direction.downcase.to_sym) { raise InvalidDirection, direction }
          end
        end
      end
    end
  end
end
