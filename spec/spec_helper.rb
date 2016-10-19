$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "qbo/sandbox"
require "awesome_print"
require "webmock/rspec"

def fixture(name)
  File.read "#{__dir__}/fixtures/#{name}.json"
end
