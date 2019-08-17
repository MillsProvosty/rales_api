require 'rails_helper'

describe "Items Search Controller" do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)

    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @item4 = create(:item, merchant: @merch2)
    @item5 = create(:item, merchant: @merch2)
    @item6 = create(:item, merchant: @merch2)

    @id = @item1.id
  end

  it "returns a single item by id" do
    get "/api/v1/items/find?=#{@id}"
    expect(response).to have_http_status(:success)

    item = JSON.parse(response.body)

    expect(item["data"]).to be_kind_of(Hash)
    expect(item["data"]["id"].to_i).to eq(@id)
    expect(item["data"]["attributes"]["id"]).to eq(@id)
    expect(item["data"]["attributes"]["merchant_id"]).to eq(@merch1.id)
    expect(item["data"]["attributes"]["unit_price"]).to be_kind_of(Integer)
  end

  it "returns all items" do
    get "/api/v1/items/find_all?name=#{@item2.name}"
    expect(response).to have_http_status(:success)

    items = JSON.parse(response.body)

    expect(items["data"]).to be_kind_of(Array)
    expect(items["data"].count).to eq(6)
    expect(items["data"][1]["attributes"]["id"]).to be_kind_of(Integer)
    expect(items["data"][2]["attributes"]).to be_present
  end
end
