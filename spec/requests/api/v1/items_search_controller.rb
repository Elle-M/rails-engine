require "spec_helper"

describe "Items Search API" do
  before :each do
    merchant = create(:merchant, 3)
    item = create(:item, 3)
  end

  it "can find all items by search criteria" do
    item_1 = Item.first
    get "/api/v1/items/find_all?name=#{item_1.name}"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(items.count).to eq(1)
    expect(items.first[:attributes][:name]).to eq(item_1.name)
    expect(items.first[:attributes][:description]).to eq(item_1.description)
    expect(items.first[:attributes][:unit_price]).to eq(item_1.unit_price)
    expect(items.first[:attributes][:merchant_id]).to eq(item_1.merchant_id)
  end
 
  it "returns an error if item does not exist" do
    get "/api/v1/items/find_all?name=notaname"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end

  it "return the first object in the database in case-insensitive alphabetical order if multiple matches are found" do
    item_1 = Item.first.name.downcase
    get "/api/v1/items/find_all?name=#{item_1.name}"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.first[:attributes][:name]).to eq(Item.first.name)
  end

  it "allows for partial matches" do
    item_1 = Item.first.name[0..3]
    get "/api/v1/items/find_all?name=#{item_1}"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.first[:attributes][:name]).to eq(Item.first.name)
  end

  it "allows user to specify a 'name' query parameter" do
    item_4 = create(:item, name: "Gold Ring")

    search = "?name=ring"
    get "/api/v1/items/find_all#{search}"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.first[:attributes][:name]).to eq(Item.first.name)
  end

  it "can return a price greater than or equal to the specified price" do
    item_1 = Item.first
    get "/api/v1/items/find_all?min_price=#{item_1.unit_price}"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.first[:attributes][:name]).to eq(Item.first.name)
  end

  it "can return a price less than or equal to the specified price" do
    item_1 = Item.first
    get "/api/v1/items/find_all?max_price=#{item_1.unit_price}"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.first[:attributes][:name]).to eq(Item.first.name)
  end

  it "can return a price between the specified prices" do
    item_1 = Item.first
    get "/api/v1/items/find_all?min_price=#{item_1.unit_price}&max_price=#{item_1.unit_price}"

    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.first[:attributes][:name]).to eq(Item.first.name)
  end
end