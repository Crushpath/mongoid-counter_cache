module Mongoid
  module CounterCache
    class UpdateCounterCache
      include Resque::Plugins::UniqueJob

      def self.queue
        Mongoid::CounterCache.resque_queue
      end

      def self.perform(object, id, relation)
        object = object.constantize.where(_id: id).first
        object.update_counter_cache(relation) if object
      end

    end
  end
end
