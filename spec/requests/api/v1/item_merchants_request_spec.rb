require "rails_helper"

describe "Items API" do
  xit "can get the merchant data for an item" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(merchant.id)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to eq(merchant.name)
  end
end