require 'rails_helper'

describe "Invoice Items Search Controller" do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)

    @inv1 = create(:invoice, merchant: @merch1, customer: @cust1)
    @inv2 = create(:invoice, merchant: @merch1, customer: @cust1)

    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)

    @invitem1 = create(:invoice_item, invoice: @inv1, item: @item1)
    @invitem2 = create(:invoice_item, invoice: @inv1, item: @item1)
    @invitem3 = create(:invoice_item, invoice: @inv1, item: @item1)
    @invitem4 = create(:invoice_item, invoice: @inv1, item: @item2)
    @invitem5 = create(:invoice_item, invoice: @inv1, item: @item2)
    @invitem6 = create(:invoice_item, invoice: @inv2, item: @item2)
    @invitem7 = create(:invoice_item, invoice: @inv2, item: @item3)
    @invitem8 = create(:invoice_item, invoice: @inv2, item: @item3)

    @id = @inv1.id
  end

  it "returns a single invoice by id" do
    get "/api/v1/invoices/#{@id}/invoice_items"

    expect(response).to have_http_status(:success)

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].first).to be_kind_of(Hash)
    expect(invoice_items["data"].first["attributes"]["id"]).to eq(@invitem1.id)
    expect(invoice_items["data"].first["attributes"]["invoice_id"]).to eq(@id)
    expect(invoice_items["data"].first["attributes"]["item_id"]).to be_kind_of(Integer)
    expect(invoice_items["data"].first["attributes"]["id"]).to_not eq(@invitem2.id)
  end
end
