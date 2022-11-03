# frozen_string_literal: true

require_relative 'bin/setup'

Setup.init

require "#{Setup.root_directory}/build"

nil while ARGV.shift

IRB.start(Setup.root_directory)
