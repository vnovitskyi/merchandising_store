describe ItemsController, type: :request do
  describe 'GET /api/items/' do
    let(:expected_response) do
      {
        'data' => [{'code' => 'MUG', 'name' => 'Reedsy Mug', 'price' => '6.0',
                    'gid' => '883a9cdc-a6ad-40b7-a68b-8f029a21d2e8'},
                   {'code' => 'HOODIE', 'name' => 'Reedsy Hoodie ', 'price' => '20.0',
                    'gid' => 'ed995ee2-9e35-46a7-8e6d-f12cfbf246c5'}]
      }
    end

    before do
      create(:item, :mug)
      create(:item, :hoodie)
      api_get '/api/items/'
    end

    it 'returns serialized items' do
      expect(json_response).to include(expected_response)
    end

    it 'returns successful response code' do
      expect(response.code).to eq('200')
    end
  end

  describe 'PUT /api/items/:id' do
    subject(:update_item_request) { api_put "/api/items/#{item_id}", {price: new_price} }

    let(:item) { create(:item, :mug) }
    let(:item_id) { item.id }
    let(:new_price) { 99 }

    context 'with valid price and item id' do
      let(:expected_response) do
        {'data' => {'code' => 'MUG', 'name' => 'Reedsy Mug', 'price' => '99.0',
                    'gid' => '883a9cdc-a6ad-40b7-a68b-8f029a21d2e8'}}
      end

      it 'updates item price' do
        expect { update_item_request }.to change { item.reload.price }.to(99)
      end

      it 'returns successful response code' do
        update_item_request
        expect(response.code).to eq('200')
      end

      it 'returns serialized item' do
        update_item_request
        expect(json_response).to include(expected_response)
      end
    end

    context 'with invalid price' do
      let(:new_price) { -99 }

      it 'does not update item price' do
        expect { update_item_request }.not_to change { item.reload.price }
      end

      it 'returns error response code' do
        update_item_request
        expect(response.code).to eq('422')
      end

      it 'returns error message' do
        update_item_request
        expect(json_response).to include('errors' => ['Validation failed: Price must be greater than 0'])
      end
    end

    context 'with invalid item id' do
      let(:item_id) { '100500' }

      it 'returns error response code' do
        update_item_request
        expect(response.code).to eq('404')
      end

      it 'returns error message' do
        update_item_request
        expect(json_response).to include('errors' => ["Couldn't find Item with 'id'=100500"])
      end
    end
  end
end
