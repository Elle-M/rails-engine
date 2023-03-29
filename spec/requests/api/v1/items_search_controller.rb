require "spec_helper"

describe "Items Search API" do
  before :each do
    merchant = create(:merchant, 3)
    item = create(:item, 3)
  end

  it "can find all items by search criteria" do
    item_1 = Item.first
    get "/api/v1/items/find_all?name=#{item_1.name}"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(items.count).to eq(1)
    expect(items.first[:attributes][:name]).to eq(item_1.name)
    expect(items.first[:attributes][:description]).to eq(item_1.description)
    expect(items.first[:attributes][:unit_price]).to eq(item_1.unit_price)
    expect(items.first[:attributes][:merchant_id]).to eq(item_1.merchant_id)
  end
end