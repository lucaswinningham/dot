# frozen_string_literal: true

require 'refinements/string_refinements/kebab_case'
require 'refinements/string_refinements/snake_case'

using Refinements::StringRefinements::KebabCase
using Refinements::StringRefinements::SnakeCase

module Build
  module Util
    class Tmux
      module Mixins
        module Command
          class << self
            def included(base)
              base.extend ClassMethods
            end

            def curate(command, *args, **options)
              switches = options.fetch(:switches, {})
              flags = options.fetch(:flags, {})
              quiet = options.fetch(:quiet, false)
              parts = ['tmux', command]

              switches.filter { |_, v| v }.tap do |filtered_switches|
                parts.push "-#{filtered_switches.keys.join}" if filtered_switches.any?  
              end

              parts.push(flags.map { |k, v| "-#{k} #{v}" }.join(' ')) if flags.compact.any?

              parts.push(args.compact.join(' ')) if args.compact.any?

              parts.push('> /dev/null 2>&1') if quiet

              parts.join(' ')
            end
          end

          module ClassMethods
            def included(base)
              command_method = method(:command)
              method_name = module_name.snake_case
              command_string_method_name = "#{method_name}_command_string"

              base.define_method method_name do |*args, **kwargs, &block|
                execute_command(command_method.call(*args, **kwargs, &block))
              end

              base.define_method command_string_method_name do |*args, **kwargs, &block|
                command_method.call(*args, **kwargs, &block)
              end

              aliases.each do |a|
                base.alias_method(:"#{a}", method_name)
                base.alias_method(:"#{a}_command_string", command_string_method_name)
              end

              unless method_defined? :execute_command
                base.define_method :execute_command do |*args, **kwargs, &block|
                  raise NotImplementedError
                end
              end
            end

            def command(*args, **kwargs, &block)
              switches = all_switches.each_with_object({}) do |(key, value), hash|
                value = kwargs.fetch(value) { kwargs.fetch(key, nil) }
                hash[key] = value unless value.nil?
              end

              flags = all_flags.each_with_object({}) do |(key, value), hash|
                value = kwargs.fetch(value) { kwargs.fetch(key, nil) }
                hash[key] = value unless value.nil?
              end

              Command.curate(
                module_name.kebab_case,
                *args,
                switches: switches,
                flags: flags,
                quiet: @quiet
              )
            end

            def aliases
              Marshal.load(Marshal.dump(all_aliases))
            end

            private

            def aka(aka)
              all_aliases.push aka
            end

            def switch(**hash)
              all_switches.merge! hash
            end

            def flag(**hash)
              all_flags.merge! hash
            end

            def quiet
              @quiet = true
            end

            def optional(key); end # TODO for say [shell-command] in new-window
            def required(key); end # TODO for say channel in wait-for

            def module_name
              @module_name ||= name.split('::').last
            end

            def all_aliases
              @all_aliases ||= []
            end

            def all_switches
              @all_switches ||= {}
            end

            def all_flags
              @all_flags ||= {}
            end
          end
        end
      end
    end
  end
end
