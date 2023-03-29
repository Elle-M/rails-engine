require "rails_helper"

describe "Merchants API" do
  it "can get all items for a given a merchant" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item[:data]).to eq(item[:name])
      expect(item[:data]).to eq(item[:description])
      expect(item[:data]).to eq(item[:unit_price])
      expect(item[:data]).to eq(item[:merchant_id])
    end
  end
end 