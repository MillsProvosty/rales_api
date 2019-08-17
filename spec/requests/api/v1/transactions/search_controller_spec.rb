require 'rails_helper'

describe "Transaction Search Controller" do
  before :each do
    @merch1 = create(:merchant)
    @cust1 = create(:customer)

    @invoice1 = create(:invoice, merchant: @merch1, customer: @cust1)
    @invoice2 = create(:invoice, merchant: @merch1, customer: @cust1)

    @tns1 = create(:transaction, invoice: @invoice1)
    @tns2 = create(:transaction, invoice: @invoice1)
    @tns3 = create(:transaction, invoice: @invoice1)
    @tns4 = create(:transaction, invoice: @invoice2)
    @tns5 = create(:transaction, invoice: @invoice2)
    @tns6 = create(:transaction, invoice: @invoice2)

    @id = @tns1.id
    @invid = @invoice1.id

    @result = @tns1.result
  end

  it "returns a single transaction" do
    get "/api/v1/transactions/find?id=#{@id}"
    expect(response).to have_http_status(:success)

    transaction = JSON.parse(response.body)

    expect(transaction["data"]).to be_kind_of(Hash)
    expect(transaction["data"]["id"].to_i).to eq(@tns1.id)
    expect(transaction["data"]["attributes"]["id"]).to eq(@tns1.id)
    expect(transaction["data"]["attributes"]["name"]).to eq(@name1)
  end

  it "returns all transactions" do
    get "/api/v1/transactions/find_all?result=#{@result}"
    expect(response).to have_http_status(:success)

    transactions = JSON.parse(response.body)

    expect(transactions["data"]).to be_kind_of(Array)
    expect(transactions["data"].count).to eq(6)
    expect(transactions["data"][1]["attributes"]["id"]).to be_kind_of(Integer)
    expect(transactions["data"][2]["attributes"]["name"]).to eq(@name2)
  end
end
