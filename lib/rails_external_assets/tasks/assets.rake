# based on https://www.tomdooner.com/2014/06/29/webpack.html
require 'rake'

Rake::Task['assets:precompile'].enhance(['assets:compile_environment'])

namespace :assets do
  # set prerequisites for the assets:precompile task
  task :compile_environment => :build_external_assets do
    Rake::Task['assets:environment'].invoke
  end

  desc 'Build external assets'
  task :build_external_assets do
    sh "NODE_ENV=#{Rails.env} #{RailsExternalAssets.config.build_script}"
  end

  task :clobber do
    rm_rf File.join('public', RailsExternalAssets.config.base_path)
  end
end
