# frozen_string_literal: true

require_relative 'split_case'

module Refinements
  module StringRefinements
    using SplitCase

    module KebabCase
      refine String do
        def kebab_case
          split_case.join('-')
        end
      end
    end
  end
end
