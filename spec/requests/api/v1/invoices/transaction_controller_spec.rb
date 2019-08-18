require 'rails_helper'

describe "Transaction Search Controller" do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)

    @inv1 = create(:invoice, merchant: @merch1, customer: @cust1)
    @inv2 = create(:invoice, merchant: @merch1, customer: @cust1)
    @inv3 = create(:invoice, merchant: @merch1, customer: @cust1)
    @inv4 = create(:invoice, merchant: @merch2, customer: @cust2)
    @inv5 = create(:invoice, merchant: @merch2, customer: @cust2)
    @inv6 = create(:invoice, merchant: @merch2, customer: @cust2)

    @id = @inv1.id

    @trans1 = create(:transaction, invoice: @inv1)
    @trans2 = create(:transaction, invoice: @inv1)
    @trans3 = create(:transaction, invoice: @inv1)
    @trans4 = create(:transaction, invoice: @inv4)
    @trans5 = create(:transaction, invoice: @inv5)
    @trans6 = create(:transaction, invoice: @inv6)
  end

  it "returns a single invoice by id" do
    get "/api/v1/invoices/#{@id}/transactions"

    expect(response).to have_http_status(:success)

    transactions = JSON.parse(response.body)

    expect(transactions["data"].first).to be_kind_of(Hash)
    expect(transactions["data"].first["attributes"]["id"]).to eq(@trans1.id)
    expect(transactions["data"].first["attributes"]["invoice_id"]).to eq(@id)
    expect(transactions["data"].first["attributes"]["credit_card_number"]).to be_kind_of(String)
    expect(transactions["data"].first["attributes"]["id"]).to_not eq(@trans2.id)
  end
end
