# frozen_string_literal: true

require_relative 'mixins/command'

# new-window (alias: neww)
#   [-abdkPS]
#   [-c start-directory] [-e environment] [-F format] [-n window-name] [-t target-window]
#   [shell-command]

# -e takes the form ‘VARIABLE=value’ and sets an environment
#    variable for the newly created window; it may be specified
#    multiple times.

module Build
  module Util
    class Tmux
      module NewWindow
        include Mixins::Command

        aka :neww

        switch a: :insert_after
        switch b: :insert_before
        switch d: :background
        switch k: :destroy_if_exists
        switch P: :print_info
        switch S: :select_if_exists

        flag c: :start_directory
        # flag e: :environment_variables # TODO
        flag F: :format
        flag n: :window_name
        flag t: :target_window
      end
    end
  end
end
