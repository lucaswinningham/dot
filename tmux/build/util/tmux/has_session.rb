# frozen_string_literal: true

require_relative 'mixins/command'

# has-session (alias: has)
#   [-t target-session]

module Build
  module Util
    class Tmux
      module HasSession
        include Mixins::Command

        aka :has

        flag t: :target_session

        quiet
      end
    end
  end
end
