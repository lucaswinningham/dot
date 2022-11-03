# frozen_string_literal: true

require 'shellwords'

class Session
  class Window
    class Pane
      class Command
        def initialize(**options)
          @options = options
        end

        def run
          channel = util.concurrency.pane_channel(context: context)

          util.concurrency.await_pane_idle(channel: "#{channel}:commands", pane_id: pane_id)
          util.tmux.send_keys(command.shellescape,  'Enter', target_pane: pane_id)
        end

        private

        def command
          @command ||= @options.fetch(:command)
        end

        def util
          @util ||= @options.fetch(:util)
        end

        def context
          @context ||= @options.fetch(:context)
        end
  
        def pane_id
          @pane_id ||= context.fetch(:pane_id)
        end
      end
    end
  end
end
