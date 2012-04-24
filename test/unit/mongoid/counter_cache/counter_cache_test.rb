require 'minitest_helper'

describe Mongoid::CounterCache do

  describe '.counter_cache' do

    let(:offer) do
      Offer.new
    end

    describe 'with a relation name of :product' do

      it 'should create #update_product_count method' do
        offer.methods.must_include(:update_product_count)
        offer.product = Product.create
        offer.update_product_count
      end

    end

    describe 'with multiple relations' do

      it 'should work the same' do
        [:update_product_count, :update_store_count].each do |method|
          offer.methods.must_include(method)
        end
      end

    end

    describe 'for each model' do

      let(:models) do
        [Product.new, Store.new]
      end

      it 'should include #update_counter_cache method' do
        models.each do |model|
          model.must_respond_to :update_counter_cache
        end
      end

      it 'should have a corresponding async method' do
        models.each do |model|
          model.must_respond_to :async_update_counter_cache
        end
      end

    end

  end

  describe 'callbacks' do

    describe 'after save' do

      it 'should update products_count for both old and new relation' do

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

      it 'should update products_count for relation' do

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
