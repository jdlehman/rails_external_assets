module RailsExternalAssets
  module Rails
    module ViewHelpers
      include RailsExternalAssets::AssetFinder

      def external_asset_js(path)
        external_asset(path) { |p| javascript_include_tag p }
      end

      def external_asset_css(path)
        external_asset(path) { |p| stylesheet_link_tag p }
      end

      def external_asset_img(path)
        external_asset(path) { |p| image_tag p }
      end
    end
  end
end
