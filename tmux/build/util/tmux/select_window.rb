# frozen_string_literal: true

require_relative 'mixins/command'

# select-window (alias: selectw)
#   [-lnpT]
#   [-t target-window]

module Build
  module Util
    class Tmux
      module SelectWindow
        include Mixins::Command

        aka :selectw

        switch l: :last_window
        switch n: :next_window
        switch p: :previous_window
        switch T: :like_last_window

        flag t: :target_window
      end
    end
  end
end
