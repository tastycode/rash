module Rash
  class Plugins < Hash

    def execute(line)
      keys.inject(line) do |returned_line, key|
        next unless key.kind_of? Regexp
        next unless line =~ key
        returned_line = fetch(key).invoke(returned_line)
      end  || line
    end

    def handle_result(line, output)

    end
  end
end
