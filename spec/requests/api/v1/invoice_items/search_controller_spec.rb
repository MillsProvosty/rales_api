require 'rails_helper'

describe "Invoice Items Search Controller" do
  before :each do
    @merch1 = create(:merchant)
    @cust1 = create(:customer)

    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)

    @inv1 = create(:invoice, merchant: @merch1, customer: @cust1)
    @inv2 = create(:invoice, merchant: @merch1, customer: @cust1)
    @inv3 = create(:invoice, merchant: @merch1, customer: @cust1)

    @invitem1 = create(:invoice_item, item: @item1, invoice: @inv1)
    @invitem2 = create(:invoice_item, item: @item1, invoice: @inv1)
    @invitem3 = create(:invoice_item, item: @item2, invoice: @inv2)
    @invitem4 = create(:invoice_item, item: @item2, invoice: @inv2)
    @invitem5 = create(:invoice_item, item: @item3, invoice: @inv3)
    @invitem6 = create(:invoice_item, item: @item3, invoice: @inv3)

    @id = @invitem1.id
  end

  it "returns a single invoice_item by id" do
    get "/api/v1/invoice_items/find?=#{@id}"
    expect(response).to have_http_status(:success)

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]).to be_kind_of(Hash)
    expect(invoice_item["data"]["id"].to_i).to eq(@invitem1.id)
    expect(invoice_item["data"]["attributes"]["id"]).to eq(@invitem1.id)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item1.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@inv1.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@invitem1.quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@invitem1.unit_price)
  end

  it "returns all invoice_items" do
    get "/api/v1/invoice_items/find_all?name=#{@name2}"
    expect(response).to have_http_status(:success)

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"]).to be_kind_of(Array)
    expect(invoice_items["data"].count).to eq(6)
    expect(invoice_items["data"][1]["attributes"]["id"]).to be_kind_of(Integer)
    expect(invoice_items["data"][2]["attributes"]).to be_present
  end
end
