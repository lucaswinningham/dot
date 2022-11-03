# frozen_string_literal: true

require_relative 'mixins/command'

# wait-for (alias: wait)
#   [-L | -S | -U]
#   channel

module Build
  module Util
    class Tmux
      module WaitFor
        include Mixins::Command

        aka :wait

        switch L: :lock
        switch S: :signal
        switch U: :unlock

        # mutually_exclusive!(:L, :S, :U) # TODO
      end
    end
  end
end
