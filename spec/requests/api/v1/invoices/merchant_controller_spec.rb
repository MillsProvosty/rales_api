require 'rails_helper'

describe "Items Merchant Controller" do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)

    @cust1 = create(:customer)
    @cust2 = create(:customer)

    @inv1 = create(:invoice, merchant: @merch1, customer: @cust1)

    @id = @inv1.id
  end

  it "returns a single invoice by id" do
    get "/api/v1/invoices/#{@id}/merchants"

    expect(response).to have_http_status(:success)

    merchant = JSON.parse(response.body)

    expect(merchant["data"]).to be_kind_of(Hash)
    expect(merchant["data"].count).to eq(3)
    expect(merchant["data"]["attributes"]["id"]).to eq(@merch1.id)
    expect(merchant["data"]["attributes"]["id"]).to be_kind_of(Integer)
    expect(merchant["data"]["attributes"]["id"]).to_not eq(@merch2.id)
  end
end
