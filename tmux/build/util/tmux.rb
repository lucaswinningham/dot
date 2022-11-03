# frozen_string_literal: true

# require 'serialization'

require_relative 'tmux/attach_session'
require_relative 'tmux/clear_history'
require_relative 'tmux/display_message'
require_relative 'tmux/has_session'
require_relative 'tmux/kill_session'
require_relative 'tmux/kill_window'
require_relative 'tmux/new_session'
require_relative 'tmux/new_window'
require_relative 'tmux/select_window'
require_relative 'tmux/select_pane'
require_relative 'tmux/send_keys'
require_relative 'tmux/split_window'
require_relative 'tmux/wait_for'

module Build
  module Util
    class Tmux
      include AttachSession
      include ClearHistory
      include DisplayMessage
      include HasSession
      include KillSession
      include KillWindow
      include NewSession
      include NewWindow
      include SelectWindow
      include SelectPane
      include SendKeys
      include SplitWindow
      include WaitFor

      # include Serialization

      # required(:cmd, readable: true)

      attr_reader :cmd

      def initialize(cmd:)
        @cmd = cmd
      end

      def execute_command(command)
        cmd.call(command)
      end

      def current_session_id
        display_message('"#{session_id}"', print: true)
      end

      def current_window_id
        display_message('"#{window_id}"', print: true)
      end

      def current_pane_id
        display_message('"#{pane_id}"', print: true)
      end
    end
  end
end
