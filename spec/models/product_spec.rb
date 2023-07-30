require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      # Create fake test data
      @category = Category.create(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price: 1000.50,
        quantity: 5,
        category: @category
      )
    end

    it 'Product with all four fields set will save successfully' do
      expect(@product).to be_valid
    end

    it 'Product with no name is invalid' do
      @product.name = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'Product with no price is invalid' do
      @product.price_cents = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'Product with no quantity is invalid' do
      @product.quantity = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'Product with no category is invalid' do
      @product.category = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end