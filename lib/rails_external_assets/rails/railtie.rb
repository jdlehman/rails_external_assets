module RailsExternalAssets
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load 'rails_external_assets/tasks/assets.rake'
      end

      initializer 'rails_external_assets.initialize' do |app|
        ActionView::Base.send :include, ViewHelpers

        if app.config.respond_to?(:assets)
          app.config.assets.configure do |env|
            env.prepend_path(File.join('public', RailsExternalAssets.config.base_path))
            RailsExternalAssets.config.sprockets_directives.each do |directive|
              env.register_preprocessor directive[:mime_type], RailsExternalAssets::Sprockets::DirectiveProcessor.new(comments: directive[:comments])
            end
          end
        else
          RailsExternalAssets.config.sprockets_directives.each do |directive|
            app.assets.register_preprocessor directive[:mime_type], RailsExternalAssets::Sprockets::DirectiveProcessor.new(comments: directive[:comments])
          end
        end
      end
    end
  end
end
