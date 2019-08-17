require 'rails_helper'

describe "Customer API" do
  before :each do
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @cust3 = create(:customer)
    @cust4 = create(:customer)
    @cust5 = create(:customer)
    @cust6 = create(:customer)
    @cust7 = create(:customer)
    @cust8 = create(:customer)

    @id = @cust1.id
  end

  it "returns index of customers" do

    get "/api/v1/customers"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(8)
    expect(customers["data"].first["attributes"]["first_name"]).to be_kind_of(String)
    expect(customers["data"].first["attributes"]["last_name"]).to eq(@cust1.last_name)
    expect(customers["data"].first["attributes"]["id"]).to be_kind_of(Integer)
    expect(customers["data"].first["id"].to_i).to eq(@id)
  end

  it "returns index of customers" do

    get "/api/v1/customers/#{@id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"].to_i).to eq(@id)
    expect(customer["data"]["attributes"]["first_name"]).to be_kind_of(String)
    expect(customer["data"]["attributes"]["last_name"]).to be_kind_of(String)
    expect(customer["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end

  it "can find a random customer" do
    get "/api/v1/customers/random"
    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random["data"]).to be_kind_of(Hash)
    expect(random["data"]["attributes"]).to be_present
    expect(random.count).to eq(1)
    expect(random["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end
end
