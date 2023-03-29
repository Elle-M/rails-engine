require "spec_helper"

describe "Merchants API" do
  before :each do
    create_list(:merchant, 3)
  end
  
  it "sends a list of merchants" do
    get "/api/v1/merchants"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant[:data]).to eq(merchant[:name])
    end
  end

  it "can get one merchant by its id" do
    get "/api/v1/merchants/#{Merchant.first.id}"

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchants[:id]).to eq(Merchant.first.id.to_s)
    expect(merchants[:attributes][:name]).to be_a(String)
  end
end