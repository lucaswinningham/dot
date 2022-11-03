# frozen_string_literal: true

require_relative 'mixins/command'

# display-message (alias: display)
#   [-aINpv]
#   [-c target-client] [-d delay] [-t target-pane]
#   [message]

module Build
  module Util
    class Tmux
      module DisplayMessage
        include Mixins::Command

        aka :display

        switch a: :list_format
        switch I: :forward_input
        switch N: :ignore_input
        switch p: :print
        switch v: :verbose

        flag c: :target_client
        flag d: :delay
        flag t: :target_pane
      end
    end
  end
end
