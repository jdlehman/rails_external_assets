require 'spec_helper'

describe RailsExternalAssets::Configuration do
  describe '.config' do
    it 'reads/writes to config' do
      RailsExternalAssets.config.base_path = 'test'

      expect(RailsExternalAssets.config.base_path).to eq 'test'
    end
  end

  describe '.reset' do it 'resets config' do
      RailsExternalAssets.config.base_path = 'test'
      RailsExternalAssets.reset
      expect(RailsExternalAssets.config.base_path).not_to eq 'test'
    end
  end

  describe '.configure' do
    it 'allows configuration in a block' do
      RailsExternalAssets.configure do |config|
        config.base_path = 'test'
      end
      expect(RailsExternalAssets.config.base_path).to eq 'test'
    end
  end

  describe '#initialize' do
    it 'sets default configs' do
      config = RailsExternalAssets::Configuration.new
      expect(config.base_path).to eq '/external-assets/'
      expect(config.manifest_file).to eq 'public/external-assets/manifest.json'
      expect(config.sprockets_directives).to eq [
        { mime_type: 'application/javascript', comments: ['//', ['/*', '*/']] },
        { mime_type: 'text/css', comments: ['//', ['/*', '*/']] }
      ]
      expect(config.cache_manifest).to eq true
    end
  end
end
