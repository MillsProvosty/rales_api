require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many :items }
  end

  describe "business logic" do
    before :each do
      @merch1 = create(:merchant)
      @merch2 = create(:merchant)
      @merch3 = create(:merchant)
      @merch4 = create(:merchant)
      @merch5 = create(:merchant)
      @merch6 = create(:merchant)
      @merch7 = create(:merchant)

      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)

      @item1 = create(:item, merchant: @merch1, unit_price: 4)
      @item2 = create(:item, merchant: @merch2, unit_price: 4)
      @item3 = create(:item, merchant: @merch3, unit_price: 4)
      @item4 = create(:item, merchant: @merch3, unit_price: 4)
      @item5 = create(:item, merchant: @merch3, unit_price: 4)

      @inv1 = create(:invoice, merchant: @merch1, customer: @cust1)
      @inv2 = create(:invoice, merchant: @merch1, customer: @cust2)
      @inv3 = create(:invoice, merchant: @merch2, customer: @cust1)
      @inv4 = create(:invoice, merchant: @merch2, customer: @cust2)
      @inv5 = create(:invoice, merchant: @merch3, customer: @cust1)
      @inv6 = create(:invoice, merchant: @merch3, customer: @cust2)

      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)
      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)
      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)
      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)
      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)
      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)
      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)
      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)
      @invitems = create(:invoice_items, invoice: @inv1, merchant: @merch1)


      @tran1 = create(:transaction, invoice: @invoice1)
      @tran2 = create(:transaction, invoice: @invoice2)
      @tran3 = create(:transaction, invoice: @invoice3)
      @tran4 = create(:transaction, invoice: @invoice4)
      @tran5 = create(:transaction, invoice: @invoice5)
    end
  end
end
