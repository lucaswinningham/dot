# frozen_string_literal: true

require 'serialization'

require_relative 'panes'

module Build
  class WindowDefinition
    include Serialization

    class Error < StandardError; end
    class WindowNameRequired < Error; end

    readable(:default, default: false)
    readable(:name, required: true, error: WindowNameRequired)
    readable(:panes, default: {}, loads: ->(panes) { Panes.new panes })

    def session_id=(session_id)
      @session_id = session_id
      panes.session_id = session_id
    end

    def id=(id)
      @id = id
      panes.window_id = id
    end

    def create
      Build::Util.concurrency.with_lock(session_channel) do
        Build::Util.tmux.new_window(
          window_name: name,
          start_directory: panes.definitions.first&.directory || '$HOME'
        )

        self.id = Build::Util.tmux.current_window_id
        panes.seed_pane_id = Build::Util.tmux.current_pane_id
      end
    end

    def build
      if panes.definitions.any?
        panes.build
        panes.default.select
      end
    end

    def select
      Build::Util.tmux.select_window(target_window: @id)
    end

    private

    def session_channel
      Build::Util.concurrency.session_channel(session_id: @session_id)
    end
  end
end
