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

    


    end
  end


end
