require 'singleton'
module Rash
  class Configuration
    include Singleton

    def initialize
      @stored_config = stored_config
    end
    def stored_config
      return unless Dir.exists?(rash_path)
      return @stored_config if @stored_config
      Dir.glob(File.join(rash_path, "*.plugin*")).each do |plugin_path|
        p = Plugin.new(plugin_path)
        index_plugin(p.regex, p)
      end
    end

    def index_plugin(regex, plugin)
      plugins[regex] = plugin
    end

    def plugins
      @plugins ||= Plugins.new
    end

    private


    def rash_path
      ENV['RASH_HOME'] || File.join(ENV['HOME'], ".rash")
    end

    class << self
      def configuration
        instance.stored_config
      end
      def method_missing(key, *args)
        return instance.send(key, *args) if instance.respond_to?(key)
        super
      end
    end
  end
end
