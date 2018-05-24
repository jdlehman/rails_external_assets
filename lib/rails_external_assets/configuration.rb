module RailsExternalAssets
  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.reset
    @config = Configuration.new end

  def self.configure
    yield(config)
  end

  class Configuration
    attr_accessor :base_path,
                  :manifest_file,
                  :sprockets_directives,
                  :build_script,
                  :cache_manifest

    def initialize
      # base path should be off Rails public/
      @base_path = '/external-assets/'
      @manifest_file = 'public/external-assets/manifest.json'
      @sprockets_directives = [
        { mime_type: 'application/javascript', comments: ['//', ['/*', '*/']] },
        { mime_type: 'text/css', comments: ['//', ['/*', '*/']] }
      ]
      @build_script = 'echo "You did not define a build script"'
      @cache_manifest = true
    end
  end
end
