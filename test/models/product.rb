class Product
  include Mongoid::Document
  include Mongoid::CounterCache

  has_many :offers
  belongs_to :store

  counter_cache :store

  field :offers_count, type: Integer, default: 0

end
