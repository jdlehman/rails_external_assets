RailsExternalAssets.configure do |config|
  # location of manifest file
  config.manifest_file = 'public/webpack-assets/manifest.json'
  # location of assets off of public dir: `public/webpack-assets`
  config.base_path = '/webpack-assets/'
  # called before assets:precompile
  config.build_script = 'npm run build'
  # add scss mime_type for external_require sprockets directives
  config.sprockets_directives << { mime_type: 'text/scss', comments: ['//', ['/*', '*/']] }
end
