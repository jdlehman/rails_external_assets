# Changelog

## 0.6.0 (2018-5-24)

Added:

- Option `cache_manifest` to specify whether or not to cache the manifest. This can now be set to false to handle manifest changes in development. [714b51c](../../commit/714b51c)

## 0.5.0 (2018-4-24)

Added:

- Manifest file is now cached to prevent reads on each asset lookup. [868e707](../../commit/868e707)

## 0.4.0 (2017-1-10)

Fixed:

- Sprockets methods like `asset_path` are no longer accidentally overloaded by methods in the `RailsExternalAssets::AssetFinder` module. [a426a4d](../../commit/a426a4d)

Changed:

- The `RailsExternalAssets::AssetFinder` is now a class instead of a module. The method names are the same as they were in the module, but they are now class methods. This won't break anything unless you were manually using the module yourself. [a426a4d](../../commit/a426a4d)

## 0.3.1 (2017-1-9)

Fixed:

- Fixed default `sprockets_directives` config. `application/css` is the incorrect mime type, and it should be `text/css`. [3c6ea98](../../commit/3c6ea98)

## 0.3.0 (2016-6-2)

Added:

- Added `external_require_directory` and `external_require_tree` Sprockets directives. [c8adab7](../../commit/c8adab7)

Changed:

- Rails view helpers `external_asset_js` and `external_asset_css` no longer require file extensions. [5bb278b](../../commit/5bb278b)
- `external_require` Sprockets directive does not need an explicit extension. It will be inferred if not provided. [d8be100](../../commit/d8be100)
