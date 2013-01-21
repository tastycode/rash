module Rash
  class Plugin
    def initialize(path)
      raise ArgumentError, "Plugin not found #{path}" unless File.exists?(path)
      @path = path
    end

    def invoke(line)
      catch(:halt) {
        proc.call(line)
      }
    end

    def regex
     %r{#{code.lines.first[1..-1].chomp}}
    end

    def proc
      @klass ||= eval(code, binding)
    end

    private

    def code
      @code ||= File.read(@path)
    end
  end
end
