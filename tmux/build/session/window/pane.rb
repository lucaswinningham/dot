# frozen_string_literal: true

require_relative 'panes'

require_relative 'pane/command'
require_relative 'pane/layout'
require_relative 'pane/placeholder'

module Build
  class Session
    class Window
      class Pane
        attr_accessor :id

        def initialize(**options)
          @options = options
        end

        def build
          if panes.any?
            channel = util.concurrency.session_channel(context: context)

            util.concurrency.with_lock(channel) { panes.seed id }

            panes.build
          else
            channel = util.concurrency.pane_channel(context: context.merge(pane_id: id))

            util.concurrency.with_lock(channel) { commands.each(&:run) }

            placeholder.fill
          end
        end

        def select
          util.tmux.select_pane(target_pane: id)
        end

        def layout
          @layout ||= Layout.new(layout: config.fetch(:layout, {}), util: util)
        end

        def dir
          @dir ||= config.fetch(:dir) { panes.first&.dir || '$HOME' }
        end

        private

        def config
          @config ||= @options.fetch(:pane)
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

        def commands_config
          @commands_config ||= config.fetch(:commands, []) || []
        end

        def commands
          @commands ||= commands_config.map do |command|
            Command.new(
              command: command || nil,
              util: util,
              context: context.merge(pane_id: id)
            )
          end
        end

        def placeholder
          @placeholder ||= Placeholder.new(
            placeholder: config.fetch(:placeholder, {}),
            util: util,
            context: context.merge(pane_id: id)
          )
        end

        def panes
          @panes ||= Panes.new(
            panes: config.fetch(:panes, {}) || {},
            util: util,
            context: context
          )
        end
      end
    end
  end
end
