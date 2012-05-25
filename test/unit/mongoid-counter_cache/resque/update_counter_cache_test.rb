require 'minitest_helper'

describe Mongoid::CounterCache::UpdateCounterCache do

  it 'returns nil if document does not exist' do
    proc { Resque.enqueue(Mongoid::CounterCache::UpdateCounterCache, 'Store', '4f97f393e9bb16b429000001', 'offers') }.must_output(nil)
  end

  describe 'resque' do

    before do
      @queue = Mongoid::CounterCache.resque_queue
      Mongoid::CounterCache.resque_queue = :test
      Resque.inline = false
    end

    after do
      Mongoid::CounterCache.resque_queue = @queue
      Resque.inline = true
    end
    
    let(:store) { Store.create }

    it 'does not queue same job more than once' do
      2.times { Resque.enqueue(Mongoid::CounterCache::UpdateCounterCache, 'Store', store.id, 'offers') }
      Resque.size(Mongoid::CounterCache.resque_queue).must_equal(1)
    end

  end

end
