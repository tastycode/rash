module Rash
  class Plugins < Hash

    def execute(line)
      keys.inject(line) do |returned_line, key|
        next unless key.kind_of? Regexp
        next unless line =~ key
        returned_line = fetch(key).execute_hook(:before, returned_line)
      end  || line
    end

    def handle_result(out, err, line)
      result = keys.inject([line, out, err]) do |(rline, rout, rerr), key|
        next unless key.kind_of? Regexp
        next unless rline =~ key
        rout, rerr, rline  = fetch(key).execute_hook(:after, rout, rerr, rline)
      end 
    end
  end
end
