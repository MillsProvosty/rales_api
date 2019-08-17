require 'rails_helper'

describe "Merchant Search Controller" do
  before :each do
    @merch1 = create(:merchant, name: "Merch 1")
    @merch2 = create(:merchant, name: "Merch 2")
    @merch3 = create(:merchant, name: "Merch 3")
    @merch4 = create(:merchant, name: "Merch 4")
    @merch5 = create(:merchant, name: "Merch 4")
    @merch6 = create(:merchant, name: "Merch 4")
    @name1 = @merch1.name
    @name2 = @merch4.name
  end

  it "returns a single merchant" do
    get "/api/v1/merchants/find?name=#{@name1}"
    expect(response).to have_http_status(:success)

    merchant = JSON.parse(response.body)

    expect(merchant["data"]).to be_kind_of(Hash)
    expect(merchant["data"]["id"].to_i).to eq(@merch1.id)
    expect(merchant["data"]["attributes"]["id"]).to eq(@merch1.id)
    expect(merchant["data"]["attributes"]["name"]).to eq(@name1)
  end

  it "returns all merchants" do
    get "/api/v1/merchants/find_all?name=#{@name2}"
    expect(response).to have_http_status(:success)

    merchants = JSON.parse(response.body)

    expect(merchants["data"]).to be_kind_of(Array)
    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"][1]["attributes"]["id"]).to be_kind_of(Integer)
    expect(merchants["data"][2]["attributes"]["name"]).to eq(@name2)
  end
end
