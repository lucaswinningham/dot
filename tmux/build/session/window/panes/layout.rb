# frozen_string_literal: true

require_relative 'layout/direction'

class Session
  class Window
    class Panes
      class Layout
        def initialize(**options)
          @options = options
        end

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

        def config
          @config ||= @options.fetch(:layout)
        end

        def panes
          @panes ||= @options.fetch(:panes)
        end

        def max_percent
          @max_percent ||= [total_explicitly_allocated_pane_percentage, 100].max
        end

        def default_pane_layout_percent
          @default_pane_layout_percent ||= (
            (max_percent - total_explicitly_allocated_pane_percentage) /
              (panes.count - explicitly_allocated_panes.count)
          )
        end

        def explicitly_allocated_panes
          @explicitly_allocated_panes ||= panes.filter { |pane| pane.layout.percent }
        end

        def total_explicitly_allocated_pane_percentage
          @total_explicitly_allocated_pane_percentage ||=
            explicitly_allocated_panes.map(&:layout).map(&:percent).sum
        end
      end
    end
  end
end
