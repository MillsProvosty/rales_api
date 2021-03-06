require 'rails_helper'

describe "Invoice Itmes API" do
  before :each do
    @merch = create(:merchant)
    @cust = create(:customer)
    @item = create(:item, merchant: @merch)

    @inv = create(:invoice, customer: @cust, merchant: @merch)

    @invitem1 = create(:invoice_item, invoice: @inv, item: @item)
    @invitem2 = create(:invoice_item, invoice: @inv, item: @item)
    @invitem3 = create(:invoice_item, invoice: @inv, item: @item)
    @invitem4 = create(:invoice_item, invoice: @inv, item: @item)
    @invitem5 = create(:invoice_item, invoice: @inv, item: @item)
    @invitem6 = create(:invoice_item, invoice: @inv, item: @item)
    @invitem7 = create(:invoice_item, invoice: @inv, item: @item)
    @invitem8 = create(:invoice_item, invoice: @inv, item: @item)

    @id = @invitem1.id
  end

  it "returns index of invoices" do

    get "/api/v1/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(8)
    expect(invoice_items["data"].first["attributes"]["item_id"]).to be_kind_of(Integer)
    expect(invoice_items["data"].first["attributes"]["item_id"]).to eq(@item.id)
    expect(invoice_items["data"].first["attributes"]["invoice_id"]).to be_kind_of(Integer)
    expect(invoice_items["data"].first["attributes"]["invoice_id"]).to eq(@inv.id)
    expect(invoice_items["data"].first["attributes"]["id"]).to be_kind_of(Integer)
  end

  it "returns index of invoices" do

    get "/api/v1/invoice_items/#{@id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["attributes"]["id"]).to eq(@id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to be_kind_of(Integer)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@inv.id)
    expect(invoice_item["data"]["attributes"]["item_id"]).to be_kind_of(Integer)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item.id)
    expect(invoice_item["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end

  it "can find a random invoice item" do
    get "/api/v1/invoice_items/random"
    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random["data"]).to be_kind_of(Hash)
    expect(random["data"]["attributes"]).to be_present
    expect(random.count).to eq(1)
    expect(random["data"]["attributes"]["id"]).to be_kind_of(Integer)
  end
end
