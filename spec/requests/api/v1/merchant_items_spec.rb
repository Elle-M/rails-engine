require "rails_helper"

describe "Merchants API" do
  before :each do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)
  end

  it "can get all items for a given a merchant" do
    merchant = Merchant.first
    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant.items.count).to eq(3)
    end
  end

  # it "returns an error if merchant does not exist" do
  #   get "/api/v1/merchants/1/items"

  #   expect(response.status).to eq(404)
  # end
end 