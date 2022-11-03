# frozen_string_literal: true

require_relative 'mixins/command'

# split-window (alias: splitw)
#   [-bdfhIvPZ]
#   [-c start-directory] [-e environment] [-l size] [-t target-pane] [-F format]
#   [shell-command]

# -e takes the form ‘VARIABLE=value’ and sets an environment
#    variable for the newly created window; it may be specified
#    multiple times.

module Build
  module Util
    class Tmux
      module SplitWindow
        include Mixins::Command

        aka :splitw

        switch b: :left_or_above
        switch d: :background
        switch f: :full_span
        switch h: :horizontal
        switch I: :forward_input
        switch v: :vertical
        switch P: :print_info
        switch Z: :zoom

        flag c: :start_directory
        # flag e: :environment_variables # TODO
        flag l: :size
        flag t: :target_pane
        flag F: :format
      end
    end
  end
end
