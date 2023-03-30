require "spec_helper"

describe "Merchants Search API" do
  before :each do
    create_list(:merchant, 3)
  end

  it "can find a merchant by name" do
    get "/api/v1/merchants/find?name=#{Merchant.first.name}"

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]
    
    expect(merchants[:attributes]).to have_key(:name)
    expect(merchants[:attributes][:name]).to be_a(String)
  end
end