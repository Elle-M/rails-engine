require "spec_helper"

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key("name")
      # expect(merchant[:data][:attributes]).to have_key("name")
      expect(merchant["name"]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response.status).to eq(200)

      expect(merchant).to have_key("name")
    # expect(merchant[:data][:attributes]).to have_key("name")
    expect(merchant["name"]).to be_a(String)
  end
end