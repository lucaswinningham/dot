# frozen_string_literal: true

require_relative 'mixins/command'

# kill-window (alias: killw)
#   [-a]
#   [-t target-window]

module Build
  module Util
    class Tmux
      module KillWindow
        include Mixins::Command

        aka :killw

        switch a: :all_except_target

        flag t: :target_window
      end
    end
  end
end
