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
    @invoice7 = create(:invoice, merchant: @merch2, customer: @cust2)
    @invoice8 = create(:invoice, merchant: @merch2, customer: @cust2)

    @id = @merch1.id
  end

  it "returns a single merchants invoices" do
    get "/api/v1/merchants/#{@id}/invoices"
    expect(response).to have_http_status(:success)

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(4)
    expect(invoices["data"].first).to be_kind_of(Hash)
    expect(invoices["data"].first["attributes"]["merchant_id"]).to eq(@id)
    expect(invoices["data"].first["attributes"]["merchant_id"]).to_not eq(@merch2.id)
    expect(invoices["data"].first["attributes"]["id"]).to eq(@invoice1.id)
  end
end
