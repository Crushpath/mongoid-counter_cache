class Store
  include Mongoid::Document
  
  has_many :products
  has_many :offers
  
  field :offers_count, type: Integer, default: 0
  field :products_count, type: Integer, default: 0
  
end
