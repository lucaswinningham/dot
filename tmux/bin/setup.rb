# frozen_string_literal: true

require 'rubygems'
require 'bundler'

require_relative 'setup/environment'
require_relative 'setup/ruby_library_groups'

module Setup
  class << self
    def init
      @init ||= true.tap do
        $LOAD_PATH.unshift(lib_directory) unless $LOAD_PATH.include?(lib_directory)

        ENV["BUNDLE_GEMFILE"] = "#{root_directory}/Gemfile"
        Bundler.setup(:default, environment)
        Bundler.require(:default, environment)

        ruby_library_groups.require(:default, environment)
      end
    end

    def root_directory
      @root_directory ||= File.expand_path('..', __dir__)
    end

    def lib_directory
      @lib_directory ||= "#{root_directory}/lib"
    end

    def environment
      @environment ||= Environment.new(ENV['ENVIRONMENT'] || :development)
    end

    private

    def ruby_library_groups
      @ruby_library_groups ||= RubyLibraryGroups.new do |ruby_library_groups|
        ruby_library_groups.merge :default do
          require 'json'
          require 'logger'
          require 'shellwords'
          require 'yaml'
        end

        ruby_library_groups.merge :development do
          require 'irb'
        end
      end
    end
  end
end
