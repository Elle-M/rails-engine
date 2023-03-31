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

  

  it "return the first object in the database in case-insensitive alphabetical order if multiple matches are found" do
    search = Merchant.first.name.downcase
    get "/api/v1/merchants/find?name=#{search}"

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchants[:attributes][:name]).to eq(Merchant.first.name)
  end

  xit "allows for partial matches" do
    search = Merchant.first.name[0..3]
    get "/api/v1/merchants/find?name=#{search}"

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchants[:attributes][:name]).to eq(Merchant.first.name)
  end

  it "allows user to specify a 'name' query parameter" do   
    merchant_4 = create(:merchant, name: "Ring World")

    search = "?name=ring World"
    get "/api/v1/merchants/find#{search}"

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]

    expect(response).to be_successful
    expect(status).to eq(200)
    expect(merchants[:attributes][:name]).to eq(merchant_4.name)
  end

  it "can return an error if merchant does not exist" do
    get "/api/v1/merchants/find?name=notaname"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end