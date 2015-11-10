# Common files
require 'pp'
require 'pathname'

ROOT_PATH = Pathname.new File.expand_path('../..', __FILE__)

def ROOT(file)
  ROOT_PATH + file
end

# # http://stackoverflow.com/questions/3372254/how-to-tell-bundler-where-the-gemfile-is
ENV['BUNDLE_GEMFILE'] = ROOT('Gemfile').to_s

require 'bundler'
Bundler.require

# Ensure existing folders
%w(tmp).each do |path|
  ROOT(path).mkpath
end

# Required folders
%w(lib).each do |folder|
  $: << ROOT(folder)
end
