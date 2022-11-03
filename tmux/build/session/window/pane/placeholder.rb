# frozen_string_literal: true

require 'shellwords'

class Session
  class Window
    class Pane
      class Placeholder
        def initialize(**options)
          @options = options
        end

        def fill
          return unless text || clear?

          util.concurrency.await_pane_idle(context: context)

          if clear?
            util.tmux.send_keys('C-l', target_pane: pane_id) # TODO: Make C-l configurable.
            sleep 1

            # In example.yaml, it seems the first pane or two's history isn't completely cleared.
            util.tmux.clear_history(target_pane: pane_id)
          end

          util.tmux.send_keys(text.shellescape, target_pane: pane_id) if text
        end

        def text
          @text ||= config.fetch(:text, nil)
        end

        private

        def config
          @config ||= @options.fetch(:placeholder)
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

        def clear?
          @clear ||= config.fetch(:clear, nil)
        end
      end
    end
  end
end
