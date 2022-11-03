# frozen_string_literal: true

require 'serialization'

module Build
  class PaneDefinition
    class Placeholder
      include Serialization

      readable(:text)
      readable(:clear)

      attr_writer :session_id, :window_id, :pane_id

      def fill
        return unless text || clear

        Build::Util.concurrency.await_pane_idle(
          session_id: @session_id,
          window_id: @window_id,
          pane_id: @pane_id
        )

        if clear
          Build::Util.tmux.send_keys('C-l', target_pane: @pane_id) # TODO: Make C-l configurable.
          sleep 1

          # In example.yaml, it seems the first pane or two's history isn't completely cleared.
          Build::Util.tmux.clear_history(target_pane: @pane_id)
        end

        Build::Util.tmux.send_keys(text.shellescape, target_pane: @pane_id) if text
      end
    end
  end
end
