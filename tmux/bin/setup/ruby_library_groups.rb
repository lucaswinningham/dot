# frozen_string_literal: true

module Setup
  class RubyLibraryGroups
    attr_reader :groups

    def initialize(&block)
      @groups = {}

      block&.call(self)
    end

    def merge(group_name, &block)
      groups.merge! group_name => block
    end

    def require(*group_names)
      groups.slice(*group_names).values.each(&:call)
    end
  end
end
