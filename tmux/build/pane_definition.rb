# frozen_string_literal: true

require 'serialization'

require_relative 'panes'

require_relative 'pane_definition/commands'
require_relative 'pane_definition/layout'
require_relative 'pane_definition/placeholder'

module Build
  class PaneDefinition
    include Serialization

    readable(
      :commands,
      default: [],
      loads: ->(commands) { Commands.new commands }
    )

    readable(:default, default: false)
    # readable(:directory).default('$HOME').loads(proc { |directory, panes| directory || panes.definitions.first&.dir || '$HOME' }) # TODO
    readable(:layout, default: {}, loads: ->(layout) { Layout.new layout })
    readable(:panes, default: {}, loads: ->(panes) { Panes.new panes })
    readable(:placeholder, default: {}, loads: ->(placeholder) { Placeholder.new placeholder })

    attr_reader :id

    def session_id=(session_id)
      @session_id = session_id

      commands.session_id = session_id
      panes.session_id = session_id
      placeholder.session_id = session_id
    end

    def window_id=(window_id)
      @window_id = window_id

      commands.window_id = window_id
      panes.window_id = window_id
      placeholder.window_id = window_id
    end

    def id=(id)
      @id = id

      commands.pane_id = id
      panes.seed_pane_id = id
      placeholder.pane_id = id
    end

    def build
      if panes.definitions.any?
        panes.build
      else
        Build::Util.concurrency.with_lock(pane_channel) { commands.run }

        placeholder.fill
      end
    end

    def select
      Build::Util.tmux.select_pane(target_pane: @id)
    end

    def directory
      @directory ||= serialization_hash.fetch(:directory) do
        panes.definitions.first&.directory || '$HOME'
      end
    end

    private

    def pane_channel
      Build::Util.concurrency.pane_channel(
        session_id: @session_id,
        window_id: @window_id,
        pane_id: @id
      )
    end
  end
end
