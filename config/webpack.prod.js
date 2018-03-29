
var path = require('path');
var webpack = require('webpack');
var merge = require('webpack-merge');
var dev = require('./webpack.dev');
var UglifyJsPlugin = require('uglifyjs-webpack-plugin');

module.exports = merge(dev, {
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"'
      }
    }),
    new UglifyJsPlugin({
      test: /\.js($|\?)/i
    })
  ]
});
