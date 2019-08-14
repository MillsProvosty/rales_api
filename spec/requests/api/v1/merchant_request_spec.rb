require 'rails_helper'

describe "Merchant API" do
  before :each do
    create_list(:merchant, 10)
    get "/api/v1/merchants"
  end

  it "returns index of merchants" do

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    
    expect(merchants.count).to eq(10)
    expect(merchants.first["name"]).to be_kind_of(String)
    expect(merchants.first["created_at"]).to be_kind_of(String)
    expect(merchants.first["id"]).to be_kind_of(Integer)
  end
end
