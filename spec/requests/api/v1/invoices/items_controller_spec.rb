require 'rails_helper'

describe "Items Search Controller" do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)

    @inv1 = create(:invoice, merchant: @merch1, customer: @cust1)
    @inv2 = create(:invoice, merchant: @merch1, customer: @cust1)

    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)

    @id = @inv1.id
  end

  it "returns a single invoice by id" do
    get "/api/v1/invoices/#{@id}/items"

    expect(response).to have_http_status(:success)

    items = JSON.parse(response.body)

    expect(items["data"].first).to be_kind_of(Hash)
    expect(items["data"].first.count).to eq(3)
    expect(items["data"].first["attributes"]["id"]).to eq(@item1.id)
    expect(items["data"].first["attributes"]["merchant_id"]).to eq(@merch1.id)
    expect(items["data"].first["attributes"]["merchant_id"]).to be_kind_of(Integer)
    expect(items["data"].first["attributes"]["id"]).to_not eq(@item2.id)
  end
end
