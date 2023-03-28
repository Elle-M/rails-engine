require "rails_helper"

describe "Merchants API" do
  it "can get all items for a given a merchant" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key("name")
      expect(item["name"]).to be_a(String)
    end
  end
end 