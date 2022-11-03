# frozen_string_literal: true

require_relative 'mixins/command'

# attach-session (alias: attach)
#   [-dErx] [-c working-directory] [-f flags] [-t target-session]

module Build
  module Util
    class Tmux
      module AttachSession
        include Mixins::Command

        aka :attach

        switch d: :detach_clients
        switch E: :skip_environment_update
        switch r: :read_only
        switch x: :sighup

        flag c: :working_directory
        flag f: :flags
        flag t: :target_session
      end
    end
  end
end
