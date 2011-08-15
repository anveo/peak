$: << 'lib'

require 'rubygems'
require 'bundler'

Bundler.require

@app_root = Pathname.new(File.dirname(__FILE__)).expand_path

#require 'rack/coffee'
#use Rack::Coffee, {
  #:root => File.join(@app_root, "lib/peak-app/views/javascripts"),
  #:urls => '/javascripts'
#}

require 'peak-app'
run Peak::Application
