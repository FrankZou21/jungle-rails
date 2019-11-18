require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "Initiallizes properly" do
      category = Category.create(:name => "Something")
      product = Product.create(:name => "Anything", :price => 1500, :quantity => 10, :category => category)
      expect(product).to be_valid
    end

    it "Cannot create product without name" do
      category = Category.create(:name => "Something")
      product = Product.create(:price => 1500, :quantity => 10, :category => category)
      expect(product.errors.full_messages[0]).to eq "Name can't be blank"
    end

    it "Cannot create product without price" do
      category = Category.create(:name => "Something")
      product = Product.create(:name => "Anything", :quantity => 10, :category => category)
      expect(product.errors.full_messages[2]).to eq "Price can't be blank"
    end

    it "Cannot create product without quantity" do
      category = Category.create(:name => "Something")
      product = Product.create(:name => "Anything", :price => 1500, :category => category)
      expect(product.errors.full_messages[0]).to eq "Quantity can't be blank"
    end

    it "Cannot create product without category" do
      category = Category.create(:name => "Something")
      product = Product.create(:name => "Anything", :price => 1500, :quantity => 10)
      expect(product.errors.full_messages[0]).to eq "Category can't be blank"
    end
  end
end
