require 'readline'
require 'colorist'
require 'rainbow'
require 'open3'

module Rash
  class CLI
    def repl
      while line = Readline.readline("-> ", true)
          line_to_execute = Rash::Configuration.plugins.execute(line)
          pid = fork {
              stdin, stdout, stderr = Open3.popen3(line_to_execute)
              out, err = [stdout.read, stderr.read]
              out, err, line = Rash::Configuration.plugins.handle_result(out, err, line_to_execute)
              print out if out.chars.any?
              $stderr.print err if err.chars.any?
          }
          Process.wait pid
      end
    end

  end
end
