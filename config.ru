require File.expand_path('../config/boot.rb', __FILE__)

require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/reloader'

require './app.rb'

map '/' do
  run App
end
