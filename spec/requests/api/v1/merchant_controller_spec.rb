require 'rails_helper'

describe "Merchant API" do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @merch3 = create(:merchant)
    @merch4 = create(:merchant)
    @merch5 = create(:merchant)
    @merch6 = create(:merchant)
    @merch7 = create(:merchant)
    @merch8 = create(:merchant)

    @id = @merch1.id
  end

  it "returns index of merchants" do

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(8)
    expect(merchants["data"].first["attributes"]["name"]).to be_kind_of(String)
    expect(merchants["data"].first["attributes"]["name"]).to eq(@merch1.name)
    expect(merchants["data"].first["attributes"]["id"]).to be_kind_of(Integer)
  end

  it "returns index of merchants" do

    get "/api/v1/merchants/#{@id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["id"]).to eq(@id)
    expect(merchant["data"]["attributes"]["name"]).to be_kind_of(String)
    expect(merchant["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end

  it "can find a random merchant" do
    get "/api/v1/merchants/random"
    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random["data"]).to be_kind_of(Hash)
    expect(random["data"]["attributes"]).to be_present
    expect(random.count).to eq(1)
    expect(random["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end
end
