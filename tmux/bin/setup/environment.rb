# frozen_string_literal: true

require 'delegate'

module Setup
  class Environment < SimpleDelegator
    class Error < StandardError; end
    class UnrecognizedEnvironmentError < Error; end

    DEVELOPMENT = :development
    TEST = :test
    PRODUCTION = :production

    def initialize(environment)
      sanitized_environment = environment.downcase.to_sym

      unless [DEVELOPMENT, TEST, PRODUCTION].include? sanitized_environment
        raise UnrecognizedEnvironmentError, environment
      end

      super sanitized_environment
    end

    def development?
      self == DEVELOPMENT
    end

    def test?
      self == TEST
    end

    def production?
      self == PRODUCTION
    end
  end
end
