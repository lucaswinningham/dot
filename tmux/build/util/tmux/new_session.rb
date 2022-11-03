# frozen_string_literal: true

require_relative 'mixins/command'

# new-session (alias: new)
#   [-AdDEPX]
#   [-c start-directory] [-e environment] [-f flags] [-F format] [-n window-name] [-s session-name]
#     [-t group-name] [-x width] [-y height]
#   [shell-command]

# -e takes the form ‘VARIABLE=value’ and sets an environment
#    variable for the newly created session; it may be specified
#    multiple times.

module Build
  module Util
    class Tmux
      module NewSession
        include Mixins::Command

        aka :new

        switch A: :attach_if_exists
        switch d: :background
        switch D: :detach_clients
        switch E: :skip_environment_update
        switch P: :print_info
        switch X: :sighup

        flag c: :start_directory
        # flag e: :environment_variables # TODO
        flag f: :flags
        flag F: :format
        flag n: :window_name
        flag s: :session_name
        flag t: :group_name
        flag x: :width
        flag y: :height
      end
    end
  end
end
