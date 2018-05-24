require 'json'

module RailsExternalAssets
  class AssetFinder
    @@manifest_file = nil
    class << self
      def external_asset(path)
        external_path = File.join(RailsExternalAssets.config.base_path, asset_path(path))
        block_given? ? yield(external_path) : external_path
      end

      def asset_path(path)
        new_path = asset_manifest[path]
        throw_unknown_path(path, RailsExternalAssets.config.manifest_file) unless new_path
        new_path
      end

      def asset_manifest
        return @@manifest_file if @@manifest_file && RailsExternalAssets.config.cache_manifest
        manifest_file = RailsExternalAssets.config.manifest_file
        throw_invalid_manifest(manifest_file) unless File.file? manifest_file
        @@manifest_file = JSON.parse(File.read manifest_file)
      end

      def clear_manifest_cache
        @@manifest_file = nil
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
end
