# frozen_string_literal: true

require_relative 'mixins/command'

# clear-history (alias: clearhist)
#   [-t target-pane]

module Build
  module Util
    class Tmux
      module ClearHistory
        include Mixins::Command

        aka :clearhist

        flag t: :target_pane
      end
    end
  end
end
