module RailsExternalAssets
  class Error < StandardError
  end

  module Errors
    # Will be thrown when file key does not exist in asset manifest
    class UnknownAssetManifestKey < RailsExternalAssets::Error; end

    # will be thrown when manifest file is not found
    class InvalidManifestFile < RailsExternalAssets::Error; end
  end
end
