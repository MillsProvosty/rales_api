require 'rails_helper'

describe "Invoices Search Controller" do
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
  end

  it "returns a single invoice by id" do
    get "/api/v1/invoices/find?=#{@id}"
    expect(response).to have_http_status(:success)

    invoice = JSON.parse(response.body)

    expect(invoice["data"]).to be_kind_of(Hash)
    expect(invoice["data"]["id"].to_i).to eq(@id)
    expect(invoice["data"]["attributes"]["id"]).to eq(@id)
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merch1.id)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@cust1.id)
  end

  it "returns all invoices" do
    get "/api/v1/invoices/find_all?name=#{@name2}"
    expect(response).to have_http_status(:success)

    invoices = JSON.parse(response.body)

    expect(invoices["data"]).to be_kind_of(Array)
    expect(invoices["data"].count).to eq(6)
    expect(invoices["data"][1]["attributes"]["id"]).to be_kind_of(Integer)
    expect(invoices["data"][2]["attributes"]).to be_present
  end
end
