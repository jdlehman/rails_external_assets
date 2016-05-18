require 'json'

module RailsExternalAssets
  module AssetFinder
    def external_asset(path)
      external_path = File.join(RailsExternalAssets.config.base_path, asset_path(path))
      block_given? ? yield(external_path) : external_path
    end

    def asset_path(path)
      manifest_file = RailsExternalAssets.config.manifest_file
      throw_invalid_manifest(manifest_file) unless File.file? manifest_file
      asset_manifest = JSON.parse(File.read manifest_file)
      new_path = asset_manifest[path]
      throw_unknown_path(path, manifest_file) unless new_path
      new_path
    end


    private

    def throw_unknown_path(path, manifest_file)
        raise Errors::UnknownAssetManifestKey.new("No corresponding file found for \"#{path}\" in \"#{manifest_file}\".")
    end

    def throw_invalid_manifest(manifest_file)
        raise Errors::InvalidManifestFile.new("Manifest file, \"#{manifest_file}\", was not found.")
    end
  end
end
