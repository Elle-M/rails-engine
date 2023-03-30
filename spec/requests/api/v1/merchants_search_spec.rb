require "spec_helper"

describe "Merchants Search API" do
  before :each do
    create_list(:merchant, 3)
    merchant_4 = create(:merchant, name: "Ring World")
  end

  it "can find a merchant by name" do
    get "/api/v1/merchants/find?name=#{Merchant.first.name}"

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]
    
    expect(merchants[:attributes]).to have_key(:name)
    expect(merchants[:attributes][:name]).to be_a(String)
  end

  #no idea how to make these work
  # xit "return the first object in the database in case-insensitive alphabetical order if multiple matches are found" do
  #   get "/api/v1/merchants/find_one, params: {name: 'ring world'}'}"

  #   merchants = JSON.parse(response.body, symbolize_names: true)
  #   merchants = merchants[:data]
    
  #   expect(merchants[:attributes][:name]).to eq(merchant_4.name)
  # end

  # xit "allows for partial matches" do
  #   get "/api/v1/merchants/find?name=#{Merchant.first.name[0..3]}"

  #   merchants = JSON.parse(response.body, symbolize_names: true)
  #   merchants = merchants[:data]
    
  #   expect(merchants[:attributes][:name]).to eq(Merchant.first.name)
  # end

  # xit "allows user to specify a 'name' query parameter" do   
  #   merchant_4 = create(:merchant, name: "Ring World")
  #   get "/api/v1/merchants/find_one" , params: {name: "ring"}

  #   merchants = JSON.parse(response.body, symbolize_names: true)
  #   merchants = merchants[:data]
  #   # require 'pry'; binding.pry
  #   expect(status).to eq(200)
  #   expect(merchants[:attributes][:name]).to eq(merchant_4.name)
  # end
end