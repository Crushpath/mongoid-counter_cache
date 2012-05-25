require 'minitest_helper'

describe Mongoid::CounterCache do

  describe '.counter_cache' do

    let(:offer) { Offer.new }

    it 'defines the needed methods' do
      [:update_product_count, :update_store_count].each do |method|
        offer.methods.must_include(method)
      end
    end

    describe 'for each model' do

      let(:models) do
        [Product.new, Store.new]
      end

      it 'defines #update_counter_cache' do
        models.each do |model|
          model.must_respond_to :update_counter_cache
        end
      end

      it 'defines #async_update_counter_cache' do
        models.each do |model|
          model.must_respond_to :async_update_counter_cache
        end
      end

    end

  end

  describe 'callbacks' do

    describe 'after save' do

      it 'updates products_count for both parents' do

        store = Store.create
        product = Product.create
        store.products << product

        store.reload.products_count.must_equal(1)

        other_store = Store.create
        other_store.products_count.must_equal(0)

        product.update_attributes(store: other_store)

        store.reload.products_count.must_equal(0)
        other_store.reload.products_count.must_equal(1)

      end

    end

    describe 'after destroy' do

      it 'updates products_count for parent' do

        store = Store.create
        product = Product.create
        store.products << product
        store.reload.products_count.must_equal(1)
        product.destroy
        store.reload.products_count.must_equal(0)

      end

    end

  end

end
