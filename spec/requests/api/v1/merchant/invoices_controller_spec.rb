require 'rails_helper'

describe "Merchant Invoices Controllers" do
  before :each do
    @merch1 = create(:merchant, name: "Merch 1")
    @merch2 = create(:merchant, name: "Merch 2")

    @cust1 = create(:customer)
    @cust2 = create(:customer)

    @invoice1 = create(:invoice, merchant: @merch1, customer: @cust1)
    @invoice2 = create(:invoice, merchant: @merch1, customer: @cust1)
    @invoice3 = create(:invoice, merchant: @merch1, customer: @cust2)
    @invoice4 = create(:invoice, merchant: @merch1, customer: @cust2)
    @invoice5 = create(:invoice, merchant: @merch2, customer: @cust1)
    @invoice6 = create(:invoice, merchant: @merch2, customer: @cust1)
    @invoice6 = create(:invoice, merchant: @merch2, customer: @cust2)
    @invoice6 = create(:invoice, merchant: @merch2, customer: @cust2)

    @id = @merch1.id
  end

  it "returns a single merchants items" do
    get "/api/v1/merchants/#{@id}/items"
    expect(response).to have_http_status(:success)

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    expect(items["data"].first).to be_kind_of(Hash)
    expect(items["data"].first["attributes"]["merchant_id"]).to eq(@id)
    expect(items["data"].first["attributes"]["merchant_id"]).to_not eq(@merch2.id)
    expect(items["data"].first["attributes"]["id"]).to eq(@item1.id)
  end
end
