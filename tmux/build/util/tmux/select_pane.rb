# frozen_string_literal: true

require_relative 'mixins/command'

# select-pane (alias: selectp)
#   [-DdeLlMmRUZ]
#   [-T title] [-t target-pane]

module Build
  module Util
    class Tmux
      module SelectPane
        include Mixins::Command

        aka :selectp

        switch D: :below
        switch d: :disable_input
        switch e: :enable_input
        switch L: :left
        switch l: :last_pane
        switch M: :clear_marked_pane
        switch m: :set_marked_pane
        switch R: :right
        switch U: :above
        switch Z: :zoom

        flag T: :title
        flag t: :target_pane
      end
    end
  end
end
