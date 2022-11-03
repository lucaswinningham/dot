# frozen_string_literal: true

require 'shellwords'

require 'serialization'

module Build
  module Util
    class Concurrency
      include Serialization

      required(:tmux)

      def with_lock(channel, &block)
        lock(channel)
        block&.call
        unlock(channel)
      end

      def lock(channel)
        tmux.wait_for(channel.shellescape, lock: true)
      end

      def unlock(channel)
        tmux.wait_for(channel.shellescape, unlock: true)
      end

      def signal(channel)
        tmux.wait_for(channel.shellescape, signal: true)
      end

      def await(channel)
        tmux.wait_for(channel.shellescape)
      end

      def await_pane_idle(options = {})
        channel = options.fetch(:channel) { pane_channel(options) }
        pane_id = options.fetch(:pane_id)

        signal_cmd = tmux.wait_for_command_string(channel.shellescape, signal: true)
        tmux.send_keys("'#{signal_cmd}' Enter", target_pane: pane_id)

        await(channel)
      end

      def session_channel(options = {})
        "#{options.fetch(:session_id)}"
      end

      def window_channel(options = {})
        "#{session_channel(options)}:#{options.fetch(:window_id)}"
      end

      def pane_channel(options = {})
        "#{window_channel(options)}:#{options.fetch(:pane_id)}"
      end
    end
  end
end
