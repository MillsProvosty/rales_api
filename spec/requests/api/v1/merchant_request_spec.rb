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

    expect(merchants.count).to eq(8)
    expect(merchants.first["name"]).to be_kind_of(String)
    expect(merchants.first["created_at"]).to be_kind_of(String)
    expect(merchants.first["id"]).to be_kind_of(Integer)
  end

  it "returns index of merchants" do

    get "/api/v1/merchants/#{@id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(@id)
    expect(merchant["name"]).to be_kind_of(String)
    expect(merchant["created_at"]).to be_kind_of(String)
    expect(merchant["id"]).to be_kind_of(Integer)
  end
end
