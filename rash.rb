require 'readline'
while line = Readline.readline("-> ", true)
    pid = fork {
          exec line
    }
    Process.wait pid
end
