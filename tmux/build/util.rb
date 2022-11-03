# frozen_string_literal: true

require 'logger'

require_relative 'util/cmd'
require_relative 'util/concurrency'
require_relative 'util/tmux'

module Build
  module Util
    class << self
      def cmd
        @cmd ||= Cmd.new(logger: logger)
      end

      def concurrency
        @concurrency ||= Concurrency.new(tmux: tmux)
      end

      def logger
        @logger ||= Logger.new(
          File.open(
            Build.configuration.meta.logger.filepath,
            Build.configuration.meta.logger.file_flags
          ),
          level: Build.configuration.meta.logger.level
        )
      end

      def tmux
        @tmux ||= Tmux.new(cmd: cmd)
      end
    end
  end
end
