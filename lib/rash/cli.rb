require 'readline'
require 'colorist'
require 'rainbow'
module Rash
  class CLI
    def repl
      while line = Readline.readline("-> ", true)
          line_to_execute = Rash::Configuration.plugins.execute(line)
          pid = fork {
                exec line_to_execute
          }
          Process.wait pid
      end
    end

  end
end
