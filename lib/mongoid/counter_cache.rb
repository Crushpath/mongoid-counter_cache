module Mongoid
  module CounterCache
    extend ActiveSupport::Concern

    module ClassMethods

      def counter_cache(relation)
        define_update_method(relation)
        define_callbacks(relation)
      end

      private
      def define_update_method(relation)
        define_method("update_#{relation}_count") do

          metadata = reflect_on_association(relation)
          klass = metadata.klass

          id_or_ids = destroyed? ? [public_send("#{relation}_id")] : public_send("#{relation}_id_change")

          klass.where(:_id.in => id_or_ids).each do |doc|
            doc.async_update_counter_cache(self.class.to_s.tableize)
          end

        end
      end

      def define_callbacks(relation)
        after_save "update_#{relation}_count", if: "#{relation}_id_changed?"
        after_destroy "update_#{relation}_count"
      end

    end

  end
end
