# frozen_string_literal: true

require 'serialization'

module Build
  class PaneDefinition
    class Layout
      include Serialization

      readable(:percent, loads: ->(percent) { percent&.to_i })
    end
  end
end
