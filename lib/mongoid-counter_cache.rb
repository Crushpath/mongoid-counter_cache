require 'mongoid'
require 'resque'

require 'mongoid-counter_cache/resque/update_counter_cache'
require 'mongoid-counter_cache/model'
require 'mongoid/counter_cache'

module Mongoid
  module CounterCache

    mattr_accessor :resque_queue
    @@resque_queue = :low

  end
end
