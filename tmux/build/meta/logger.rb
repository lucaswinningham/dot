# frozen_string_literal: true

require 'serialization'

module Build
  class Meta
    class Logger
      include Serialization

      readable(:filepath, default: "#{Build.root_directory}/logs/build.log")
      readable(:file_flags, default: File::WRONLY | File::CREAT | File::TRUNC)
      readable(:level, default: ::Logger::DEBUG)
    end
  end
end
