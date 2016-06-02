module RailsExternalAssets
  module Rails
    module ViewHelpers
      include RailsExternalAssets::AssetFinder

      def external_asset_js(path)
        ext_name = File.extname(path)
        ext = ext_name.empty? ? '.js' : ''
        external_asset("#{path}#{ext}") { |p| javascript_include_tag p }
      end

      def external_asset_css(path)
        ext_name = File.extname(path)
        ext = ext_name.empty? ? '.css' : ''
        external_asset("#{path}#{ext}") { |p| stylesheet_link_tag p }
      end

      def external_asset_img(path)
        external_asset(path) { |p| image_tag p }
      end
    end
  end
end
