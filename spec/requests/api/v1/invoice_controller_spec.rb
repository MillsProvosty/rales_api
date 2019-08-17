require 'rails_helper'

describe "Invoices API" do
  before :each do
    @cust = create(:customer)
    @merch = create(:merchant)
    @invoice1 = create(:invoice, merchant: @merch, customer: @cust)
    @invoice2 = create(:invoice, merchant: @merch, customer: @cust)
    @invoice3 = create(:invoice, merchant: @merch, customer: @cust)
    @invoice4 = create(:invoice, merchant: @merch, customer: @cust)
    @invoice5 = create(:invoice, merchant: @merch, customer: @cust)
    @invoice6 = create(:invoice, merchant: @merch, customer: @cust)
    @invoice7 = create(:invoice, merchant: @merch, customer: @cust)
    @invoice8 = create(:invoice, merchant: @merch, customer: @cust)

    @id = @invoice1.id
  end

  it "returns index of invoices" do

    get "/api/v1/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(8)
    expect(invoices.first["status"]).to be_kind_of(String)
    expect(invoices.first["merchant_id"]).to be_kind_of(Integer)
    expect(invoices.first["merchant_id"]).to eq(@merch.id)
    expect(invoices.first["customer_id"]).to be_kind_of(Integer)
    expect(invoices.first["customer_id"]).to eq(@cust.id)
    expect(invoices.first["id"]).to be_kind_of(Integer)
  end

  it "returns index of invoices" do

    get "/api/v1/invoices/#{@id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["id"]).to eq(@id)
    expect(invoice["status"]).to be_kind_of(String)
    expect(invoice["created_at"]).to be_kind_of(String)
    expect(invoice["id"]).to be_kind_of(Integer)
    expect(invoice["merchant_id"]).to eq(@merch.id)
    expect(invoice["customer_id"]).to eq(@cust.id)
  end

  it "can find a random invoice" do
    get "/api/v1/invoices/random"
    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random["data"]).to be_kind_of(Hash)
    expect(random["data"]["attributes"]).to be_present
    expect(random.count).to eq(1)
    expect(random["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end
end
