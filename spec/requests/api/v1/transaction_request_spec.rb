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

    expect(transactions.count).to eq(8)
    expect(transactions.first["credit_card_number"]).to be_kind_of(String)
    expect(transactions.first["result"]).to be_kind_of(String)
    expect(transactions.first["id"]).to be_kind_of(Integer)
    expect(transactions.first["id"]).to eq(@id)
  end

  it "returns index of transactions" do

    get "/api/v1/transactions/#{@id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["id"]).to eq(@id)
    expect(transaction["credit_card_number"]).to be_kind_of(String)
    expect(transaction["result"]).to be_kind_of(String)
    expect(transaction["id"]).to be_kind_of(Integer)
  end
end
