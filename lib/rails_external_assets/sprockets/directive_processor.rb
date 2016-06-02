module RailsExternalAssets
  module Sprockets
    class DirectiveProcessor < ::Sprockets::DirectiveProcessor
      include RailsExternalAssets::AssetFinder

       def process_external_require_directive(path)
         ext_name = File.extname(path)
         ext = ext_name.empty? ? file_extension : ''
         new_path = asset_path("#{path}#{ext}")
         process_require_directive new_path
       end

       def process_external_require_directory_directive(path)
         selected_paths = asset_manifest.keys
          .select { |key| key.match "#{File.join(path, '[^/]+\..+')}" }
          .select { |path| File.extname(path) == file_extension }
         selected_paths.each { |path| process_external_require_directive path }
       end

       def process_external_require_tree_directive(path)
         selected_paths = asset_manifest.keys
          .select { |key| key.match File.join(path) }
          .select { |path| File.extname(path) == file_extension }
         selected_paths.each { |path| process_external_require_directive path }
       end


       private

       def file_extension
         mime_ext = @environment.mime_exts.find { |_, value| value == @content_type }
         mime_ext && mime_ext[0]
       end
    end
  end
end
