require 'spec_helper'

describe RailsExternalAssets do
  it 'has a version number' do
    expect(RailsExternalAssets::VERSION).not_to be nil
  end

  it 'has a configuration class' do
    expect(RailsExternalAssets::Configuration).not_to be nil
  end

  it 'has a AssetFinder class' do
    expect(RailsExternalAssets::AssetFinder).not_to be nil
  end
end
