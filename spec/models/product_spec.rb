require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'should be a valid product' do
      @category = Category.new(name: 'category')
      @category.save
      @product = Product.new(name: 'product', price_cents: 99.99, quantity: 20, category: @category)
      @product.save

      expect(@product.valid?).to be true
    end

    it 'should not validate without a name' do
      @category = Category.new(name: 'category')
      @category.save
      @product = Product.new(name: nil, price_cents: 100, quantity: 10, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not validate without a price' do
      @category = Category.new(name: 'category')
      @category.save
      @product = Product.new(name: 'product', price_cents: nil, quantity: 10, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    
    it 'should not validate without a quantity' do
      @category = Category.new(name: 'category')
      @category.save
      @product = Product.new(name: 'product', price_cents: 400, quantity: nil, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not validate without a category' do
      @category = Category.new(name: 'category')
      @category.save
      @product = Product.new(name: 'product', price_cents: 250, quantity: 10, category: nil)
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
