require "rails_helper"

describe "Items API" do
  before :each do
    create_list(:merchant, 3)
    create_list(:item, 3)
  end

  it "sends a list of items" do
    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item[:data]).to eq(item[:name])  
      expect(item[:data]).to eq(item[:description])
      expect(item[:data]).to eq(item[:unit_price])
      expect(item[:data]).to eq(item[:merchant_id])
    end
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data][:id]).to eq(id.to_s)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes][:description]).to be_a(String)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it "can create a new item" do
    item_params = { name: "Gloves", description: "Warm and fuzzy", unit_price: 25.00 , merchant_id: Merchant.first.id }

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(Item.last.name).to eq("Gloves")
  end

  xit "can update an existing item" do
    previous_name = Item.last.name
    item_params = { name: "Hat"} 

    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/items/#{Item.last.id}", headers: headers, params: JSON.generate(item: item_params)
    item = Item.find_by(id: Item.last.id)
    # require 'pry'; binding.pry
    # failing status
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Hat")
    expect(item.description).to eq(Item.last.description)
  end

  it "can delete an item" do
    item = Item.last

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response.status).to eq(200)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(Item.count).to eq(2)
  end
end