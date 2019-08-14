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

    expect(customers.count).to eq(8)
    expect(customers.first["name"]).to be_kind_of(String)
    expect(customers.first["created_at"]).to be_kind_of(String)
    expect(customers.first["id"]).to be_kind_of(Integer)
  end

  it "returns index of customers" do

    get "/api/v1/customers/#{@id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(@id)
    expect(merchant["name"]).to be_kind_of(String)
    expect(merchant["created_at"]).to be_kind_of(String)
    expect(merchant["id"]).to be_kind_of(Integer)
  end
end
