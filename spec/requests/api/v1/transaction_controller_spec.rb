require 'rails_helper'

describe "Transaction API" do
  before :each do
    @merch = create(:merchant)
    @cust = create(:customer)
    @invoice = create(:invoice, merchant: @merch, customer: @cust)
    @transaction1 = create(:transaction, invoice: @invoice)
    @transaction2 = create(:transaction, invoice: @invoice)
    @transaction3 = create(:transaction, invoice: @invoice)
    @transaction4 = create(:transaction, invoice: @invoice)
    @transaction5 = create(:transaction, invoice: @invoice)
    @transaction6 = create(:transaction, invoice: @invoice)
    @transaction7 = create(:transaction, invoice: @invoice)
    @transaction8 = create(:transaction, invoice: @invoice)

    @id = @transaction1.id
  end

  it "returns index of transactions" do

    get "/api/v1/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(8)
    expect(transactions["data"].first["attributes"]["credit_card_number"]).to be_kind_of(String)
    expect(transactions["data"].first["attributes"]["result"]).to be_kind_of(String)
    expect(transactions["data"].first["attributes"]["id"]).to be_kind_of(Integer)
    expect(transactions["data"].first["attributes"]["id"]).to eq(@id)
  end

  it "returns index of transactions" do

    get "/api/v1/transactions/#{@id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["attributes"]["id"]).to eq(@id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to be_kind_of(String)
    expect(transaction["data"]["attributes"]["result"]).to be_kind_of(String)
    expect(transaction["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end

  it "can find a random merchant" do
    get "/api/v1/transactions/random"
    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random["data"]).to be_kind_of(Hash)
    expect(random["data"]["attributes"]).to be_present
    expect(random.count).to eq(1)
    expect(random["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end
end
