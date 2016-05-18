module RailsExternalAssets
  module Sprockets
    class DirectiveProcessor < ::Sprockets::DirectiveProcessor
      include RailsExternalAssets::AssetFinder

       def process_external_require_directive(path)
         new_path = asset_path(path)
         process_require_directive new_path
       end
    end
  end
end
