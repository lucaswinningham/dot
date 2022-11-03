# frozen_string_literal: true

module Build
  class << self
    def configuration
      @configuration ||= begin
        yaml = YAML.load_file(configuration_filepath)
        configuration_hash = JSON.parse(JSON[yaml], symbolize_names: true)
        # puts configuration_hash

        Configuration.new(configuration_hash)
      end
    end

    def call(options = {})
      rebuild_session_if_exists = options.fetch(:rebuild_session_if_exists, false)

      if Build::Util.tmux.has_session(target_session: configuration.session.name).success?
        if rebuild_session_if_exists
          kill_existing_session
          build_session
        else
          attach_to_existing_session
        end
      else
        build_session
      end
    end

    def configuration_filepath
      @configuration_filepath ||= ENV['CONFIGURATION_FILEPATH']
    end

    def root_directory
      @root_directory ||= Setup.root_directory
    end

    private

    def kill_existing_session
      puts "tmux session '#{configuration.session.name}' exists, killing..."
      Build::Util.tmux.kill_session(target_session: configuration.session.name)
    end

    def attach_to_existing_session
      puts "tmux session '#{configuration.session.name}' exists, attaching..."
      Build::Util.tmux.attach_session(target_session: configuration.session.name)
    end

    def build_session
      puts "Building tmux session from configuration file #{configuration_filepath}..."
      configuration.session.build
    end
  end
end

require_relative 'build/configuration'
require_relative 'build/util'
