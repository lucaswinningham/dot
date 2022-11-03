# frozen_string_literal: true

require 'serialization'

require_relative 'pane_definition'

require_relative 'panes/layout'

module Build
  class Panes
    include Serialization

    readable(
      :definitions,
      default: [],
      loads: lambda { |defs| defs.map { |pane_def| PaneDefinition.new pane_def } }
    )

    def layout
      @layout = Layout.new(
        @serialization_hash.fetch(:layout, {}).merge(definitions: definitions)
      )
    end

    def session_id=(session_id)
      @session_id = session_id
      definitions.each { |definition| definition.session_id = session_id }
    end

    def window_id=(window_id)
      definitions.each { |definition| definition.window_id = window_id }
    end

    def seed_pane_id=(pane_id)
      definitions.first.id = pane_id if definitions.first
    end

    def build
      return unless definitions.any?

      percent_used = 0
      last_pane_definition = definitions.first

      definitions[1..-1].each_with_index do |pane_definition, index|
        pane_percents = layout.pane_percents(pane: last_pane_definition, percent_used: percent_used)

        Build::Util.concurrency.with_lock(session_channel) do
          pane_definition.id = Build::Util.tmux.split_window(
            :"#{layout.direction}" => true,
            size: "#{pane_percents[:split_window]}%",
            start_directory: pane_definition.directory,
            target_pane: last_pane_definition.id,
            print_info: true,
            format: '"#{pane_id}"'
          )
        end

        percent_used += pane_percents[:used]
        last_pane_definition = pane_definition
      end

      threads = definitions.map { |pane_definition| Thread.new { pane_definition.build } }
      threads.each(&:join)
    end

    def default
      @default ||= definitions.find(&:default) || definitions[0]
    end

    private

    def session_channel
      Build::Util.concurrency.session_channel(session_id: @session_id)
    end
  end
end
