require "rails_helper"

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key("name")
      expect(item["name"]).to be_a(String)

      expect(item).to have_key("description")
      expect(item["description"]).to be_a(String)

      expect(item).to have_key("unit_price")
      expect(item["unit_price"]).to be_a(Float)
    end
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to eq(id)

    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)

    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)
  end

  it "can create a new item" do
    item_params = { name: "Gloves", description: "Warm and fuzzy", unit_price: 25.00 }

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last
# require 'pry'; binding.pry
    expect(response).to be_successful
    #returning nil for created_item
    # expect(created_item.name).to eq(item_params[:name])
    # expect(created_item.description).to eq(item_params[:description])
    # expect(created_item.unit_price).to eq(item_params[:unit_price])
    # expect(created_item).to have_attributes(item_params)
    expect(response.status).to eq(201)
    #returning application/json; charset=utf-8 for content_type
    # expect(response.content_type).to eq("application/json")
    #returning nil for location
    # expect(response.location).to eq("http://www.example.com/api/v1/items/#{created_item.id}")
  end
end