require 'rails_helper'

describe "Customer Search Controller" do
  before :each do
    @cust1 = create(:customer, first_name: "Cust", last_name: "1")
    @cust2 = create(:customer, first_name: "Cust", last_name: "2")
    @cust3 = create(:customer, first_name: "Cust", last_name: "3")
    @cust4 = create(:customer, first_name: "Cust", last_name: "4")
    @cust5 = create(:customer, first_name: "Cust", last_name: "5")
    @cust6 = create(:customer, first_name: "Cust", last_name: "6")
    @name1 = @cust1.first_name + " " + @cust1.last_name
    @name2 = @cust4.first_name + " " + @cust1.last_name
  end

  it "returns a single customer" do
    get "/api/v1/customers/find?name=#{@name1}"
    expect(response).to have_http_status(:success)

    customer = JSON.parse(response.body)

    expect(customer["data"]).to be_kind_of(Hash)
    expect(customer["data"]["id"].to_i).to eq(@cust1.id)
    expect(customer["data"]["attributes"]["id"]).to eq(@cust1.id)
    expect(customer["data"]["attributes"]["first_name"]).to eq(@cust1.first_name)
  end

  it "returns all customers" do
    get "/api/v1/customers/find_all?name=#{@name2}"
    expect(response).to have_http_status(:success)

    customers = JSON.parse(response.body)

    expect(customers["data"]).to be_kind_of(Array)
    expect(customers["data"].count).to eq(6)
    expect(customers["data"][1]["attributes"]["id"]).to be_kind_of(Integer)
    expect(customers["data"][2]["attributes"]).to be_present
  end
end
