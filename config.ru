$: << 'lib'

require 'rubygems'
require 'bundler'

Bundler.require

@app_root = Pathname.new(File.dirname(__FILE__)).expand_path

require 'peak-app'
run Peak::Application
