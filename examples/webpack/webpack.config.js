var webpack = require('webpack');
var path = require('path');
var glob = require('glob');
// webpack plugins
var ManifestPlugin = require('webpack-manifest-plugin');
var WriteFilePlugin = require('write-file-webpack-plugin');
// postcss plugins
var autoprefixer = require('autoprefixer');

require('dotenv').load({silent: true});

// environment variables
process.env.NODE_ENV = process.env.NODE_ENV || 'production';
process.env.BABEL_ENV = process.env.NODE_ENV;
var isProduction = process.env.NODE_ENV === 'production';
var isDevelopment = process.env.NODE_ENV === 'development';
var isStaging = process.env.NODE_ENV === 'staging';
var WEBPACK_PORT = process.env.WEBPACK_PORT || 8000;

// webpack config variables
var outputPath = path.join(__dirname, '/public/webpack-assets');

function getPlugins() {
  var plugins = [
    new webpack.optimize.OccurenceOrderPlugin(),
    new ManifestPlugin({filename: 'manifest.json'}),
    new WriteFilePlugin({log: false}),
  ];

  if (isProduction) {
    plugins.push(new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify('production')
      }
    }));
    plugins.push(new webpack.optimize.OccurenceOrderPlugin());
    plugins.push(new webpack.optimize.DedupePlugin());
    plugins.push(new webpack.optimize.UglifyJsPlugin({
      compress: {warnings: false}
    }));
  }
  return plugins;
}

function getOutputFilename(extension) {
  var outputFilename = '';
  if (isProduction) {
    outputFilename = '[name]-[chunkhash].min' + extension;
  } else {
    outputFilename = '[name]' + extension;
  }

  return outputFilename;
}

function getEntries(basePath) {
  var entries = glob.sync(path.join(basePath, '**/*.*')).reduce(function(entryMap, entry) {
    var trimmedEntry = entry.replace(basePath, '');
    var trimmedEntryWithoutExt = trimmedEntry.replace(/\..+$/, '');
    entryMap[trimmedEntryWithoutExt] = [trimmedEntry];
    return entryMap;
  }, {});
  return entries;
}

module.exports = {
  cache: true,
  debug: !isProduction,
  devtool: isProduction ? 'hidden-source-map' : 'eval-source-map',
  context: path.join(__dirname, 'app/assets/webpack'),
  entry: getEntries('app/assets/webpack/'),
  output: {
    path: outputPath,
    publicPath: '/webpack-assets/',
    filename: getOutputFilename('.js')
  },
  plugins: getPlugins(),
  resolve: {
    extensions: ['', '.js', '.scss', '.css', '.js.erb'],
    root: [path.join(__dirname, 'app/assets/webpack')],
    modulesDirectories: ['node_modules'],
    fallback: __dirname
  },
  module: {
    preLoaders: [
      { test: /\.erb$/, loader: 'uh-erb', exclude: /node_modules/ }
    ],
    loaders: [
      { test: /\.js(\.erb)?$/, loader: 'babel', exclude: /node_modules/ },
      { test: /\.css$/, loaders: ['style', 'css?sourceMap', 'postcss'], exclude: /node_modules/ },
      {
        test: /\.scss/,
        loaders: ['style', 'css?sourceMap', 'postcss', 'sass'],
        exclude: /node_modules/
      },
      { test: /\.(jpg|svgz|png|svg)$/, loader: 'file?name=[path][name]-[hash].[ext]' }
    ]
  },
  postcss: [autoprefixer],
  devServer: {
    outputPath: outputPath,
    stats: {
      hash: false,
      version: false,
      timings: true,
      assets: false,
      chunks: false,
      children: false
    },
    port: WEBPACK_PORT
  }
};
