# frozen_string_literal: true

require_relative 'mixins/command'

# send-keys (alias: send)
#   [-FHlMRX]
#   [-N repeat-count] [-t target-pane]
#   key ...

module Build
  module Util
    class Tmux
      module SendKeys
        include Mixins::Command

        aka :send

        switch F: :expand_formats
        switch H: :hex
        switch l: :disable_lookup
        switch M: :mouse_event
        switch R: :reset_terminal
        switch X: :copy_mode

        flag N: :repeat_count
        flag t: :target_pane
      end
    end
  end
end
