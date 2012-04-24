class Offer
  include Mongoid::Document
  include Mongoid::CounterCache

  belongs_to :product
  belongs_to :store

  counter_cache :product
  counter_cache :store

end
