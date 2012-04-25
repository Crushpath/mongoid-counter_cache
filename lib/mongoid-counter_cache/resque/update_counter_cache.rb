module Mongoid
  module CounterCache
    class UpdateCounterCache
      include Resque::Plugins::UniqueJob

      def self.queue
        Mongoid::CounterCache.resque_queue
      end

      def self.perform(object, id, relation)
        object = object.constantize.find(id)
        object.update_counter_cache(relation)
      end

    end
  end
end
