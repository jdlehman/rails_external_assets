require "rails_external_assets/version"
require 'rails_external_assets/errors'
require 'rails_external_assets/configuration'
require 'rails_external_assets/asset_finder'

module RailsExternalAssets
end

require 'rails_external_assets/sprockets' if defined?(Sprockets)
require 'rails_external_assets/rails' if defined?(Rails)
