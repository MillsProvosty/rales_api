require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many :items }
  end

  describe "business logic" do
    before :each do
      @merch1 = create(:merchant, name: "Doris")
      @merch2 = create(:merchant, name: "Smegal")
      @merch3 = create(:merchant, name: "Barnibus")
      @merch4 = create(:merchant, name: "Tweeker")
      @merch5 = create(:merchant, name: "Farnsby")

      @item1 = create(:item, merchant: @merch1, unit_price: 1)
      @item2 = create(:item, merchant: @merch2, unit_price: 2)
      @item3 = create(:item, merchant: @merch3, unit_price: 3)
      @item4 = create(:item, merchant: @merch3, unit_price: 4)
      @item5 = create(:item, merchant: @merch3, unit_price: 5)
      @item6 = create(:item, merchant: @merch1, unit_price: 6)
      @item7 = create(:item, merchant: @merch2, unit_price: 7)
      @item8 = create(:item, merchant: @merch4, unit_price: 8)
      @item9 = create(:item, merchant: @merch5, unit_price: 9)
      @item10 = create(:item, merchant: @merch3, unit_price: 10)

      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)

      @inv1 = create(:invoice, merchant: @merch1, customer: @cust1)
      @inv2 = create(:invoice, merchant: @merch1, customer: @cust2)
      @inv3 = create(:invoice, merchant: @merch2, customer: @cust3)
      @inv4 = create(:invoice, merchant: @merch2, customer: @cust2)
      @inv5 = create(:invoice, merchant: @merch3, customer: @cust1)
      @inv6 = create(:invoice, merchant: @merch3, customer: @cust2)
      @inv7 = create(:invoice, merchant: @merch1, customer: @cust3)
      @inv8 = create(:invoice, merchant: @merch2, customer: @cust2)
      @inv9 = create(:invoice, merchant: @merch2, customer: @cust1)
      @inv10 = create(:invoice, merchant: @merch5, customer: @cust2)
      @inv11 = create(:invoice, merchant: @merch4, customer: @cust3)
      @inv12 = create(:invoice, merchant: @merch5, customer: @cust2)

      @invitems1 = create(:invoice_item, invoice: @inv1, item: @item1, quantity: 1)
      @invitems2 = create(:invoice_item, invoice: @inv2, item: @item2, quantity: 2)
      @invitems3 = create(:invoice_item, invoice: @inv3, item: @item3, quantity: 3)
      @invitems4 = create(:invoice_item, invoice: @inv4, item: @item4, quantity: 4)
      @invitems5 = create(:invoice_item, invoice: @inv5, item: @item5, quantity: 5)
      @invitems6 = create(:invoice_item, invoice: @inv6, item: @item6, quantity: 6)
      @invitems7 = create(:invoice_item, invoice: @inv7, item: @item7, quantity: 7)
      @invitems8 = create(:invoice_item, invoice: @inv8, item: @item8, quantity: 8)
      @invitems9 = create(:invoice_item, invoice: @inv9, item: @item9, quantity: 9)
      @invitems10 = create(:invoice_item, invoice: @inv10, item: @item10, quantity: 1)
      @invitems11 = create(:invoice_item, invoice: @inv11, item: @item9, quantity: 2)
      @invitems12 = create(:invoice_item, invoice: @inv12, item: @item8, quantity: 3)
      @invitems13 = create(:invoice_item, invoice: @inv1, item: @item7, quantity: 4)
      @invitems14 = create(:invoice_item, invoice: @inv2, item: @item6, quantity: 5)
      @invitems15 = create(:invoice_item, invoice: @inv3, item: @item5, quantity: 6)
      @invitems16 = create(:invoice_item, invoice: @inv4, item: @item4, quantity: 7)
      @invitems17 = create(:invoice_item, invoice: @inv5, item: @item3, quantity: 48)
      @invitems18 = create(:invoice_item, invoice: @inv6, item: @item2, quantity: 29)
      @invitems19 = create(:invoice_item, invoice: @inv7, item: @item1, quantity: 19)

      @tran1 = create(:transaction, invoice: @inv1, result: "success")
      @tran2 = create(:transaction, invoice: @inv2, result: "success")
      @tran3 = create(:transaction, invoice: @inv3, result: "success")
      @tran4 = create(:transaction, invoice: @inv4, result: "success")
      @tran5 = create(:transaction, invoice: @inv5, result: "success")
      @tran6 = create(:transaction, invoice: @inv6, result: "failed")
      @tran7 = create(:transaction, invoice: @inv7, result: "success")
      @tran8 = create(:transaction, invoice: @inv8, result: "failed")
      @tran9 = create(:transaction, invoice: @inv9, result: "success")
      @tran10 = create(:transaction, invoice: @inv10, result: "failed")
      @tran11 = create(:transaction, invoice: @inv11, result: "success")
      @tran12 = create(:transaction, invoice: @inv12, result: "failed")
    end

    it ".most_revenue(quantity)" do
      quantity = 3
      expect(Merchant.most_revenue(quantity)).to eq([@merch3, @merch2, @merch1])
    end

    it ".most_items(quantity)" do
       quantity = 3
       expect(Merchant.most_items(quantity)).to eq([@merch3, @merch1, @merch2])
    end

    describe "Instance Methods" do
      before :each do
        @merch11 = create(:merchant, name: "Doris")

        @item1 = create(:item, merchant: @merch11, unit_price: 1)
        @item2 = create(:item, merchant: @merch11, unit_price: 2)
        @item3 = create(:item, merchant: @merch11, unit_price: 3)
        @item4 = create(:item, merchant: @merch11, unit_price: 4)
        @item5 = create(:item, merchant: @merch11, unit_price: 5)

        @cust11 = create(:customer, first_name: "Squee", last_name: "Morris")
        @cust21 = create(:customer, first_name: "Blarth", last_name: "Freeber")

        @inv1 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv2 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv3 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv4 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv5 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv6 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv7 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv8 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv9 = create(:invoice, merchant: @merch11, customer: @cust11)
        @inv10 = create(:invoice, merchant: @merch11, customer: @cust21)
        @inv11 = create(:invoice, merchant: @merch11, customer: @cust21)
        @inv12 = create(:invoice, merchant: @merch11, customer: @cust21)

        @invitems1 = create(:invoice_item, invoice: @inv1, item: @item1, quantity: 1)
        @invitems2 = create(:invoice_item, invoice: @inv2, item: @item2, quantity: 2)
        @invitems3 = create(:invoice_item, invoice: @inv3, item: @item3, quantity: 3)
        @invitems4 = create(:invoice_item, invoice: @inv4, item: @item4, quantity: 4)
        @invitems5 = create(:invoice_item, invoice: @inv5, item: @item5, quantity: 5)
        @invitems6 = create(:invoice_item, invoice: @inv6, item: @item6, quantity: 6)
        @invitems7 = create(:invoice_item, invoice: @inv7, item: @item7, quantity: 7)
        @invitems8 = create(:invoice_item, invoice: @inv8, item: @item8, quantity: 8)
        @invitems9 = create(:invoice_item, invoice: @inv9, item: @item9, quantity: 9)
        @invitems10 = create(:invoice_item, invoice: @inv10, item: @item10, quantity: 1)
        @invitems11 = create(:invoice_item, invoice: @inv11, item: @item9, quantity: 2)
        @invitems12 = create(:invoice_item, invoice: @inv12, item: @item8, quantity: 3)


        @tran1 = create(:transaction, invoice: @inv1, result: "success")
        @tran2 = create(:transaction, invoice: @inv2, result: "success")
        @tran3 = create(:transaction, invoice: @inv3, result: "success")
        @tran4 = create(:transaction, invoice: @inv4, result: "success")
        @tran5 = create(:transaction, invoice: @inv5, result: "success")
        @tran6 = create(:transaction, invoice: @inv6, result: "failed")
        @tran7 = create(:transaction, invoice: @inv7, result: "success")
        @tran8 = create(:transaction, invoice: @inv8, result: "failed")
        @tran9 = create(:transaction, invoice: @inv9, result: "success")
        @tran10 = create(:transaction, invoice: @inv10, result: "failed")
        @tran11 = create(:transaction, invoice: @inv11, result: "success")
        @tran12 = create(:transaction, invoice: @inv12, result: "failed")

      end
      it "#favorite_customer" do
        expect(@merch11.favorite_customer).to eq(@cust11)
      end 
    end
  end
end
