# frozen_string_literal: true

require 'json'

require_relative 'session/window'

module Build
  class SessionOld
    def initialize(**options)
      @options = options
    end

    def build
      unless util.tmux.has_session(target_session: name).success?
        # https://stackoverflow.com/a/66179831
        util.tmux.new_session(session_name: name, background: true, width: '-', height: '-')

        @id = util.tmux.current_session_id

        if windows.any?
          windows.each(&:create)
    
          threads = windows.map { |window| Thread.new { window.build } }
          threads.each(&:join)
    
          util.tmux.kill_window(target_window: 0) # Kill the original window.
          default_window.select
          default_window.panes.first.select
        end
      end

      util.tmux.attach_session(target_session: name)
    end

    private

    attr_reader :id

    def config
      @config ||= JSON.parse(JSON[@options.fetch(:config, {}) || {}], symbolize_names: true)
    end

    def util
      @util ||= Util.new(**(@options.fetch(:util, {}) || {}))
    end

    def name
      Build.configuration.session_name
    end

    def windows
      @windows ||= Build.configuration.windows.map do |window_config|
        Window.new(
          window: window_config || {},
          util: util,
          context: { session_id: id }
        )
      end
    end

    def default_window
      windows.find(&:default) || windows[0]
    end
  end
end
