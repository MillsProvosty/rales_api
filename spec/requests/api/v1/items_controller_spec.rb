require 'rails_helper'

describe "Items API" do
  before :each do
    @merch = create(:merchant)
    @item1 = create(:item, merchant: @merch)
    @item2 = create(:item, merchant: @merch)
    @item3 = create(:item, merchant: @merch)
    @item4 = create(:item, merchant: @merch)
    @item5 = create(:item, merchant: @merch)
    @item6 = create(:item, merchant: @merch)
    @item7 = create(:item, merchant: @merch)
    @item8 = create(:item, merchant: @merch)

    @id = @item1.id
  end

  it "returns index of items" do

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(8)
    expect(items["data"].first["attributes"]["description"]).to be_kind_of(String)
    expect(items["data"].first["attributes"]["merchant_id"]).to eq(@merch.id)
    expect(items["data"].first["attributes"]["id"]).to be_kind_of(Integer)
  end

  it "returns index of items" do

    get "/api/v1/items/#{@id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["id"]).to eq(@id)
    expect(item["data"]["attributes"]["description"]).to be_kind_of(String)
    expect(item["data"]["attributes"]["merchant_id"]).to be_kind_of(Integer)
    expect(item["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end

  it "can find a random invoice item" do
    get "/api/v1/items/random"
    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random["data"]).to be_kind_of(Hash)
    expect(random["data"]["attributes"]).to be_present
    expect(random.count).to eq(1)
    expect(random["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end
end
