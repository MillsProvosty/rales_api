require 'rails_helper'

describe "Merchant Search Controller" do
  before :each do
    @merch1 = create(:merchant, name: "Merch 1")
    @merch2 = create(:merchant, name: "Merch 2")
    @merch3 = create(:merchant, name: "Merch 3")
    @merch4 = create(:merchant, name: "Merch 4")
    @merch5 = create(:merchant, name: "Merch 5")
  end
  
  it "returns a single merchant" do
    get "/api/v1/merchants/find?name=#{@merch1.name}"
    expect(response).to have_http_status(:success)
    binding.pry
  end

  xit "returns all merchants" do

  end

end
