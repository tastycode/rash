module Rash
  class Plugin
    def initialize(path)
      raise ArgumentError, "Plugin not found #{path}" unless File.exists?(path)
      @path = path
    end

    def regex
     %r{#{code.lines.first[1..-1].chomp}}
    end

    def process_config
      eval(code, binding)
    end


    # config dsl methods, please move this into a module { 
    def before(&block)
      hooks[:before] = block
    end

    def after(&block)
      hooks[:after] = block
    end
    # }

    def execute_hook(hook_name, *args)
      process_config unless hooks.any?
      return unless hook = hooks[hook_name]
      hook.call(*args)
    end

    private

    def code
      @code ||= File.read(@path)
    end

    def hooks
      @hooks ||= {}
    end
  end
end
