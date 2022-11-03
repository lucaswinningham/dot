# frozen_string_literal: true

require_relative 'mixins/command'

# kill-session (alias: kills)
#   [-aC]
#   [-t target-session]

module Build
  module Util
    class Tmux
      module KillSession
        include Mixins::Command

        switch a: :all_except_target
        switch C: :clear_alerts

        flag t: :target_session
      end
    end
  end
end
