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
 end
