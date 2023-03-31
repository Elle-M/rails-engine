require "rails_helper"

describe "Items Search API" do
  before :each do
    create_list(:merchant, 3)
    create_list(:item, 3)
  end

  it "can get the merchant data for an item" do
    get "/api/v1/items/#{Item.last.id}/merchant"
    
    expect(response).to be_successful
    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]

    expect(merchants[:id]).to eq(Merchant.last.id.to_s)
    expect(merchants[:attributes][:name]).to be_a(String)
    expect(merchants[:attributes][:name]).to eq(Merchant.last.name)
  end

  xit "returns an error if item does not exist" do
    get "/api/v1/items/1/merchant"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end