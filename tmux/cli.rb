# frozen_string_literal: true

module MyTmux
  module CLI
    module Commands
      extend Dry::CLI::Registry

      class Console < Dry::CLI::Command
        desc 'Start an interactive console'

        def call(*, **)
          require_relative 'console'
        end
      end

      class Rebuild < Dry::CLI::Command
        desc 'Build (or rebuild) a tmux session from a configuration file'

        argument(
          :filepath,
          type: :string,
          required: true,
          desc: 'Configuration filepath'
        )

        option(
          :rebuild,
          type: :boolean,
          default: false,
          aliases: ['-r'],
          desc: 'Rebuild session if it exists'
        )

        example [
          "#{Setup.root_directory}/examples/example.yaml # Build tmux session from this filepath"
        ]

        def call(filepath:, rebuild:, **)
          require_relative 'build'

          ENV['CONFIGURATION_FILEPATH'] = filepath
          Build.call(rebuild_session_if_exists: rebuild)
        end
      end

      class Kill < Dry::CLI::Command
        desc 'Kill a tmux session by name'

        argument(
          :session_name,
          type: :string,
          required: true,
          desc: 'tmux session name'
        )

        def call(session_name:, **)
          `tmux kill-session -t #{session_name}`
        end
      end

      register 'console', Console, aliases: ['c', '-c', '--console']
      register 'build', Rebuild
      register 'kill', Kill
    end
  end
end

Dry::CLI::Parser::Result.define_singleton_method :failure do |*, **|
  help
end

Dry::CLI.new(MyTmux::CLI::Commands).call
