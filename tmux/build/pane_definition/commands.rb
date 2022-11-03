# frozen_string_literal: true

require 'shellwords'

require 'serialization'

module Build
  class PaneDefinition
    class Commands
      attr_writer :session_id, :window_id, :pane_id

      def initialize(commands)
        @commands = commands
      end

      def run
        commands.each do |command|
          Build::Util.concurrency.await_pane_idle(channel: commands_channel, pane_id: @pane_id)
          Build::Util.tmux.send_keys(command.shellescape,  'Enter', target_pane: @pane_id)
        end
      end

      private

      attr_reader :commands

      def commands_channel
        "#{pane_channel}:commands"
      end

      def pane_channel
        Build::Util.concurrency.pane_channel(
          session_id: @session_id,
          window_id: @window_id,
          pane_id: @pane_id
        )
      end
    end
  end
end
