require 'rails_helper'

describe "Merchant Items Controllers" do
  before :each do
    @merch1 = create(:merchant, name: "Merch 1")
    @merch2 = create(:merchant, name: "Merch 2")

    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @item4 = create(:item, merchant: @merch2)
    @item5 = create(:item, merchant: @merch2)
    @item6 = create(:item, merchant: @merch2)

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
