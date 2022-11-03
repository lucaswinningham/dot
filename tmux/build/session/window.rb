# frozen_string_literal: true

require_relative 'window/panes'

module Build
  class Session
    class Window
      def initialize(**options)
        @options = options
      end

      def create
        session_channel = util.concurrency.session_channel(context: context)

        util.concurrency.with_lock(session_channel) do
          util.tmux.new_window(
            window_name: name,
            start_directory: panes_config.dig(:definitions, 0, :dir) || '$HOME'
          )

          @id = util.tmux.current_window_id
          panes.seed util.tmux.current_pane_id
        end
      end

      def build
        panes.build
      end

      def default
        @default ||= config.fetch(:default, false)
      end

      def select
        util.tmux.select_window(target_window: id)
      end

      def panes_config
        @panes_config ||= config.fetch(:panes, {}) || {}
      end

      def panes
        @panes ||= Panes.new(
          panes: panes_config,
          util: util,
          context: context.merge(window_id: id)
        )
      end

      private

      attr_reader :id

      def config
        @config ||= @options.fetch(:window)
      end

      def util
        @util ||= @options.fetch(:util)
      end

      def context
        @context ||= @options.fetch(:context)
      end

      def name
        @name ||= config.fetch(:name, '')
      end
    end
  end
end
