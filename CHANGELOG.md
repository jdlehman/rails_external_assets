# Changelog

## 0.3.1 (2017-1-9)

Fixed:

- Fixed default `sprockets_directives` config. `application/css` is the incorrect mime type, and it should be `text/css`. [3c6ea98](../../commit/3c6ea98)

## 0.3.0 (2016-6-2)

Added:

- Added `external_require_directory` and `external_require_tree` Sprockets directives. [c8adab7](../../commit/c8adab7)

Changed:

- Rails view helpers `external_asset_js` and `external_asset_css` no longer require file extensions. [5bb278b](../../commit/5bb278b)
- `external_require` Sprockets directive does not need an explicit extension. It will be inferred if not provided. [d8be100](../../commit/d8be100)
