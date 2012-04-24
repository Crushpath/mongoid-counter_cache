module Mongoid
  module CounterCache
    module Model

      def update_counter_cache(relation)
        update_attribute("#{relation}_count", public_send(relation).count)
      end

      def async_update_counter_cache(relation)
        Resque.enqueue(Mongoid::CounterCache::UpdateCounterCache, self.class.name, self.id, relation)
      end

    end
  end
end

Mongoid::Document.send(:include, Mongoid::CounterCache::Model)
