require "rails_helper"

describe "Items API" do
  before :each do
    create_list(:merchant, 3)
    create_list(:item, 3)
  end

  it "can get the merchant data for an item" do
    # merchant = create(:merchant)
    # item = create(:item, merchant: merchant)
    #controller issue, checked controller, checked routes, no idea why this is failing
    # get "/api/v1/items/#{item.id}/merchant"
    get "/api/v1/items/#{Item.last.id}/merchant"
    

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(merchant.id)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to eq(merchant.name)
  end
end