# frozen_string_literal: true

require_relative 'split_case'

module Refinements
  module StringRefinements
    using SplitCase

    module SnakeCase
      refine String do
        def snake_case
          split_case.join('_')
        end
      end
    end
  end
end
