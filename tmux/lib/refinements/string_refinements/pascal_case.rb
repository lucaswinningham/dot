# frozen_string_literal: true

require_relative 'split_case'

module Refinements
  module StringRefinements
    using SplitCase

    module PascalCase
      refine String do
        def pascal_case
          split_case.map(&:capitalize).join
        end
      end
    end
  end
end
