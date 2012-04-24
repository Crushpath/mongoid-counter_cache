require 'mongoid-counter_cache'
require 'minitest/autorun'
require 'turn/autorun'

Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each { |f| require f }

Resque.inline = true

Mongoid.database = Mongo::Connection.new().db('testdb')

class MiniTest::Spec
  before :each do
    Mongoid.purge!
  end
end

Turn.config.format = :outline
