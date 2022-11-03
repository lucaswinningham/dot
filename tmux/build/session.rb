# frozen_string_literal: true

require 'serialization'

require_relative 'windows'

module Build
  class Session
    include Serialization

    class Error < StandardError; end
    class SessionNameRequired < Error; end

    readable(:name, required: true, error: SessionNameRequired)
    readable(:windows, default: {}, loads: ->(windows) { Windows.new windows })

    def build
      # https://stackoverflow.com/a/66179831
      Build::Util.tmux.new_session(session_name: name, background: true, width: '-', height: '-')

      @id = Build::Util.tmux.current_session_id

      windows.session_id = id

      if windows.definitions.any?
        windows.build
  
        Build::Util.tmux.kill_window(target_window: 0) # Kill the original window.
        windows.default.select
      end

      Build::Util.tmux.attach_session(target_session: name)
    end

    private

    attr_reader :id

    def default_window
      # windows.find(&:default) || windows[0]
      windows.default
    end
  end
end
