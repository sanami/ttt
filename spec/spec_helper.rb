require File.expand_path('../../config/boot.rb', __FILE__)
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

def fix_file(file_name)
  ROOT("spec/fixtures/#{file_name}")
end

def fix_data(file_name)
  fix_file(file_name).read
end
