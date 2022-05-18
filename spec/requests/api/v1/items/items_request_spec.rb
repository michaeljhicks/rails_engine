require 'rails_helper'

 RSpec.describe 'Items API' do
   it 'gets all items' do
     create_list(:item, 4)

     get '/api/v1/items'
     expect(response).to be_successful

     json = JSON.parse(response.body, symbolize_names: true)
     items = json[:data]

     items.each do |item|
       expect(item).to have_key(:id)
       expect(item[:id]).to be_a(String)

       expect(item).to have_key(:type)
       expect(item[:type]).to be_a(String)
       expect(item[:type]).to eq('item')

       expect(item).to have_key(:attributes)
       expect(item[:attributes]).to be_a(Hash)

       item_attributes = item[:attributes]

       expect(item_attributes).to have_key(:name)
       expect(item_attributes[:name]).to be_a(String)

       expect(item_attributes).to have_key(:description)
       expect(item_attributes[:description]).to be_a(String)

       expect(item_attributes).to have_key(:unit_price)
       expect(item_attributes[:unit_price]).to be_an(Float)

       expect(item_attributes).to have_key(:merchant_id)
       expect(item_attributes[:merchant_id]).to be_an(Integer)
     end
   end

   it 'gets one item by its id' do
     item = create(:item)

     get "/api/v1/items/#{item.id}"

     json = JSON.parse(response.body, symbolize_names: true)
     item = json[:data]

     expect(response).to be_successful

     expect(item).to have_key(:id)
     expect(item[:id]).to be_a(String)

     expect(item).to have_key(:type)
     expect(item[:type]).to be_a(String)

     expect(item).to have_key(:attributes)
     expect(item[:attributes]).to be_a(Hash)

     single_item_attributes = item[:attributes]

     expect(single_item_attributes).to have_key(:name)
     expect(single_item_attributes[:name]).to be_a(String)

     expect(single_item_attributes).to have_key(:description)
     expect(single_item_attributes[:description]).to be_a(String)

     expect(single_item_attributes).to have_key(:unit_price)
     expect(single_item_attributes[:unit_price]).to be_a(Float)

     expect(single_item_attributes).to have_key(:merchant_id)
     expect(single_item_attributes[:merchant_id]).to be_an(Integer)
   end

   it 'can create an item' do
     merchant = create(:merchant)
     item_attributes = {
       name: 'Michaels Secret Aardvark Hot Sauce',
       description: 'The Best Hot Sauce. Period.',
       unit_price: 15.99,
       merchant_id: merchant.id
     }

     headers = {'CONTENT_TYPE' => 'application/json'}

     post '/api/v1/items', headers: headers, params: JSON.generate(item_attributes)

     created_item = Item.last
     expect(response).to be_successful
     expect(created_item.name).to eq(item_attributes[:name])
     expect(created_item.description).to eq(item_attributes[:description])
     expect(created_item.unit_price).to eq(item_attributes[:unit_price])
     expect(created_item.merchant_id).to eq(item_attributes[:merchant_id])
   end

   it 'can update an item' do
     id = create(:item).id
     current_price = Item.last.unit_price
     item_attributes_price = { unit_price: 20.99 }
     headers = {'CONTENT_TYPE' => 'application/json'}

     put "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_attributes_price)
     item = Item.find_by(id: id)
     expect(response).to be_successful
     expect(item.unit_price).to_not eq(current_price)
     expect(item.unit_price).to eq(20.99)
   end

   it 'can destroy an item' do
     item = create(:item)

     expect(Item.count).to eq(1)

     delete "/api/v1/items/#{item.id}"
     expect(Item.count).to eq(0)
     expect(response.status).to eq(204)
   end
 end
