[![Gem Version](https://badge.fury.io/rb/rails_external_assets.png)](http://badge.fury.io/rb/rails_external_assets)
[![Build Status](https://secure.travis-ci.org/jdlehman/rails_external_assets.svg?branch=master)](http://travis-ci.org/jdlehman/rails_external_assets)

# RailsExternalAssets

RailsExternalAssets allows you to use the frontend build tool of your choice ([webpack](https://webpack.github.io/), [jspm](http://jspm.io/), [browserify](http://browserify.org/), etc) with Rails. Essentially you can build all (or some) of your frontend assets outside of Rails' asset pipeline, but still make use of them in Rails. The only requirement is that you provide an asset manifest file, which is a json file that maps your asset files to their final built files:

```json
{
  "js/module.js": "builds/js/module-12312abc.js",
  "js/react-component.jsx": "builds/components/react-component-ab123x.js",
  "css/styling.sass": "builds/styles/styling-129xha.css",
  "pathToPreBuiltAsset": "pathToBuiltAsset"
}
```

This means you can manage your frontend assets however you like and RailsExternalAssets gives you [Rails](http://rubyonrails.org/) view helpers and [Sprockets](https://github.com/rails/sprockets) directives to incorporate these external assets into your Rails application. In Rails environments, RailsExternalAssets also hooks into `assets:precompile` and `assets:clobber` Rake tasks.

You can use RailsExternalAssets without using Ruby on Rails, but you will have to wire up the helper methods it provides into your application yourself.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_external_assets'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_external_assets

## Usage

## With Rails

You can include your external assets in Rails with the provided view helpers or Sprockets directives.

RailsExternalAssets will also hook into the `assets:precompile` Rake command and run the shell script defined by the `build_script` config. It will also hook into the `assets:clobber` Rake command and remove all the files in the directory specified by your `base_path` config (where your assets are built).

### View Helpers

#### JavaScript

You can include a JavaScript file with `external_asset_js`. Note that the string argument must correspond to an entry in the manifest file, including the file extension. If you do not include a file extension, `js` will be used by default.

```erb
<%= external_asset_js 'myFile.js' %>
```

#### CSS

You can include a CSS file with `external_asset_css`. Note that the string argument must correspond to an entry in the manifest file, including the file extension. If you do not include a file extension, `css` will be used by default.

```erb
<%= external_asset_css 'myFile.css' %>
```

#### Image

You can include a Image file with `external_asset_img`. Note that the string argument must correspond to an entry in the manifest file, including the file extension.

```erb
<%= external_asset_img 'myFile.jpg' %>
```

### Sprockets Directives

By default, you can use the `external_require` directive in JavaScript and CSS manifest files, but you can add more (Sass, SCSS, CoffeeScript, etc) by setting the configuration (check out the configuration docks for `sprockets_directives`).

In any file type you configure the Sprockets directive to be available in you, can use the `external_require` directives to include an external asset in the Sprockets manifest. If you do not include an extension, Sprockets will try to use an extension based on the extension of the file you required it in. Sprockets will also ensure that each file is only included once, even if directives overlap and require the file more than once.

The available directives are, `external_require`, `external_require_directory`, and `external_require_tree`, corresponding to the build in directives, `require`, `require_directory`, and `require_tree`.

An example `application.js` Sprockets manifest file:

```js
//= require normalAsset
//= require more/anotherAsset
//= external_require externals/firstAsset
//= external_require externals/anotherAsset
//= external_require_directory externals/myFolder
//= external_require_tree externals/folderWithMoreFolders
```

This will include the first two JS assets, `normalAsset` and `anotherAsset` from Rails' asset pipeline, and the other JS assets, `firstAsset`, `anotherAsset`, all JS files directly in `externals/myFolder`, and all JS files in the tree `externals/folderWithMoreFolders` from your external assets. The external assets are resolved by looking up these files in the asset manifest JSON file provided.

## With Plain Ruby

`RailsExternalAssets::AssetFinder` provides three methods for your disposal.

`asset_path` takes a path to an external asset file, and returns the corresponding built asset path by looking up the key in the asset manifest JSON file.

`exeternal_asset` takes a path and returns the built asset path (the result of `asset_path`) and joins it with the base path. If a block is provided, the external asset path is passed to the block and the resulting value is returned.

`asset_manifest` is used by `asset_path`, and returns the asset manifest file parsed as JSON.

## Configuration

Configuration settings can be modified within the `RailsExternalAssets.configure` block. Or set directly off of `RailsExternalAssets.config`

```ruby
RailsExternalAssets.configure do |config|
  config.base_path = '/assets/'
  config.manifest_file = 'public/assets/asset-manifest.json'
end

RailsExternalAssets.config.base_path = '/webpack-assets/'
```

### Options

**base_path**

This is the file location off of Rails' `public/` folder that the external assets are built to.

> Defaults to `/external-assets/`

**manifest_file**

This is the file location of the asset manifest JSON file. The keys are the file paths pre-build, and the values are the file paths post-build.

> Defaults to `public/external-assets/manfest.json`

**sprockets_directives**

This is an array to configure the use of the `external_assets` Sprockets directive that is provided by RailsExternalAssets. Each item is a hash with keys for `mime_type` and the `comments` supported by the directive. Check out the [Sprockets documentation](https://github.com/rails/sprockets/blob/master/guides/extending_sprockets.md#adding-directives-to-your-extension) for more information.

> Defaults to:
```ruby
[
  { mime_type: 'application/javascript', comments: ['//', ['/*', '*/']] },
  { mime_type: 'application/css', comments: ['//', ['/*', '*/']] }
]
```

**build_script**

This is the shell script that will be run prior to `assets:precompile` in Rails or with the `rake assets:build_external_assets` command. This should be the script that builds your assets (eg: `npm run build`).

Note that in a Rails environment, `assets:clobber` will also remove all the files in your `base_path` directory (where your assets are built).

> Defaults to `echo "You did not define a build script"`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jdlehman/rails_external_assets. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
