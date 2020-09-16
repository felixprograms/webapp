require "rubygems"
require "sinatra"
require "bundler"

Bundler.require

require File.expand_path '../app.rb', __FILE__

run App
