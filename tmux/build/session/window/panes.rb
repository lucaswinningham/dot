# frozen_string_literal: true

require_relative 'pane'

require_relative 'panes/layout'

module Build
  class Session
    class Window
      class Panes
        def initialize(**options)
          @options = options
        end

        def build
          return unless any?

          percent_used = 0
          last_pane = panes.first

          panes[1..-1].each_with_index do |pane, index|
            pane_percents = layout.pane_percents(pane: last_pane, percent_used: percent_used)
            session_channel = util.concurrency.session_channel(context: context)

            util.concurrency.with_lock(session_channel) do
              util.tmux.select_window(target_window: window_id)

              util.tmux.split_window(
                :"#{layout.direction}" => true,
                size: "#{pane_percents[:split_window]}%",
                start_directory: pane.dir || "$HOME",
                target_pane: last_pane.id
              )

              pane.id = util.tmux.current_pane_id
            end

            percent_used += pane_percents[:used]
            last_pane = pane
          end

          threads = panes.map { |pane| Thread.new { pane.build } }
          threads.each(&:join)
        end

        def any?
          panes.any?
        end

        def first
          panes.first
        end

        def seed(id)
          panes.first.id = id
        end

        private

        def config
          @config ||= @options.fetch(:panes)
        end

        def util
          @util ||= @options.fetch(:util)
        end

        def context
          @context ||= @options.fetch(:context)
        end

        def window_id
          @window_id ||= context.fetch(:window_id)
        end

        def layout
          @layout ||= Layout.new(layout: config.fetch(:layout, {}), panes: panes)
        end

        def definitions
          @definitions = config.fetch(:definitions, []) || []
        end

        def panes
          @panes ||= definitions.map do |pane_config|
            Pane.new(
              pane: pane_config || {},
              util: util,
              context: context
            )
          end
        end
      end
    end
  end
end
