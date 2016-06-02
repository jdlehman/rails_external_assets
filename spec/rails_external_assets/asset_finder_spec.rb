require 'spec_helper'

describe RailsExternalAssets::AssetFinder do
  let(:asset_finder) do
    class AF
      include RailsExternalAssets::AssetFinder
    end
    AF.new
  end

  before(:each) do
    RailsExternalAssets.configure do |config|
      config.base_path = 'spec/dummy/assets'
      config.manifest_file = 'spec/dummy/assets/manifest.json'
    end
  end
  after(:each) do
    RailsExternalAssets.reset
  end

  describe '#asset_path' do
    context 'valid manifest file' do
      it 'returns the corresponding file from the manifest.json' do
        expect(asset_finder.asset_path 'raw/first.js').to eq 'built/first.min.js'
        expect(asset_finder.asset_path 'raw/second.js').to eq 'built/second.js'
        expect(asset_finder.asset_path 'raw/stylez.scss').to eq 'built/styles/stylez.css'
      end

      it 'throws an error when corresponding file cannot be found from manifest' do
        expect{asset_finder.asset_path 'raw/doesntExist.js'}.to raise_error(RailsExternalAssets::Errors::UnknownAssetManifestKey)
      end
    end

    context 'when manifest file is invalid' do
      it 'throws error when file is not found' do
        RailsExternalAssets.config.manifest_file = 'spec/dummy/assets/invalid_manifest.json'
        expect{asset_finder.asset_path 'raw/first.js'}.to raise_error(RailsExternalAssets::Errors::InvalidManifestFile)
      end

      it 'throws error when manifest is not a file' do
        RailsExternalAssets.config.manifest_file = 'spec/dummy/assets/'
        expect{asset_finder.asset_path 'raw/first.js'}.to raise_error(RailsExternalAssets::Errors::InvalidManifestFile)
      end
    end
  end

  describe '#external_asset' do
    it 'appends the asset path with the base_path' do
      expect(asset_finder.external_asset 'raw/first.js').to eq 'spec/dummy/assets/built/first.min.js'
      expect(asset_finder.external_asset 'raw/second.js').to eq 'spec/dummy/assets/built/second.js'
      expect(asset_finder.external_asset 'raw/stylez.scss').to eq 'spec/dummy/assets/built/styles/stylez.css'
    end

    context 'when a block is given' do
      it 'passes the external path to the block' do
        transformed_path = asset_finder.external_asset('raw/first.js') do |path|
          path.gsub('spec/dummy/', '')
        end
        expect(transformed_path).to eq 'assets/built/first.min.js'
      end
    end
  end

  describe '#asset_manifest' do
    it 'returns JSON asset manifest' do
      expect(asset_finder.asset_manifest).to eq ({
        'raw/first.js' => 'built/first.min.js',
        'raw/second.js' => 'built/second.js',
        'raw/stylez.scss' => 'built/styles/stylez.css'
      })
    end

    it 'throws an error when manifest is invalid' do
      RailsExternalAssets.config.manifest_file = 'spec/dummy/assets/'
      expect{asset_finder.asset_manifest}.to raise_error(RailsExternalAssets::Errors::InvalidManifestFile)
    end
  end
end
