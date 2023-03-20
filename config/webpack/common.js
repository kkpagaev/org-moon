const webpack = require("webpack");
const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");

let config = {
  entry: {
    main: path.resolve(__dirname, "entry.ts"),
  },
  output: {
    filename: "[name].bundle.js",
    path: path.resolve(__dirname, "../../public/dist"),
    publicPath: "/dist",
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js"],
    alias: {
      amber: path.resolve(__dirname, "../../lib/amber/assets/js/amber.js"),
    },
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: "ts-loader",
        exclude: /node_modules/,
      },
      {
        test: /\.ts?$/,
        use: "ts-loader",
        exclude: /node_modules/,
      },
      {
        test: /\.(sass|scss|css)$/,
        exclude: /node_modules/,
        use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"],
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        exclude: /node_modules/,
        use: ["file-loader?name=/images/[name].[ext]"],
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/,
        exclude: /node_modules/,
        use: ["file-loader?name=/[name].[ext]"],
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env"],
          },
        },
      },
    ],
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: "[name].bundle.css",
    }),
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin({
      title: "Caching",
    }),
  ],
  // For more info about webpack logs see: https://webpack.js.org/configuration/stats/
  stats: "errors-only",
};

module.exports = config;
