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
    subject(:update_item_request) { api_put "/api/items/#{item_gid}", {price: new_price} }

    let(:item) { create(:item, :mug) }
    let(:item_gid) { item.gid }
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

    context 'with invalid item gid' do
      let(:item_gid) { '100500' }

      it 'returns error response code' do
        update_item_request
        expect(response.code).to eq('404')
      end

      it 'returns error message' do
        update_item_request
        expect(json_response).to include('errors' => ["Couldn't find Item"])
      end
    end
  end

  describe 'GET /api/price/' do
    let(:mug) { create(:item, :mug) }
    let(:t_shirt) { create(:item, :t_shirt) }
    let(:hoodie) { create(:item, :hoodie) }
    let(:free_item_discount) { create(:free_item_discount) }
    let(:percentage_discount) { create(:percentage_discount) }

    before do
      create(:item_discount, discount: free_item_discount, item: mug)
      create(:item_discount, discount: percentage_discount, item: t_shirt)
      api_get '/api/items/price/', {items_gids: items_gids}
    end

    context 'when not applying discounts' do
      let(:items_gids) { [mug.gid, t_shirt.gid, hoodie.gid] }
      let(:expected_response) do
        {
          'data' => {'discount' => 0, 'total' => '41.0', 'normal_price' => '41.0'}
        }
      end

      it 'returns price for requested items' do
        expect(json_response).to include(expected_response)
      end
    end

    context 'when 2 for 1 discount' do
      let(:items_gids) { [mug.gid, t_shirt.gid, mug.gid] }
      let(:expected_response) do
        {
          'data' => {'discount' => '6.0', 'total' => '21.0', 'normal_price' => '27.0'}
        }
      end

      it 'returns price for requested items' do
        expect(json_response).to include(expected_response)
      end

      context 'when purchase 3 same items' do
        let(:items_gids) { [mug.gid, t_shirt.gid, mug.gid, mug.gid] }

        let(:expected_response) do
          {
            'data' => {'discount' => '6.0', 'total' => '27.0', 'normal_price' => '33.0'}
          }
        end

        it 'returns price for requested items' do
          expect(json_response).to include(expected_response)
        end
      end
    end

    context 'when percent discount for 3 or more' do
      let(:items_gids) { [t_shirt.gid, t_shirt.gid, t_shirt.gid] }
      let(:expected_response) do
        {
          'data' => {'discount' => '13.5', 'total' => '31.5', 'normal_price' => '45.0'}
        }
      end

      it 'returns price for requested items' do
        expect(json_response).to include(expected_response)
      end
    end

    context 'when percent discount for 3 or more items and 2 for 1 discount' do
      let(:items_gids) { [mug.gid, t_shirt.gid, t_shirt.gid, t_shirt.gid, t_shirt.gid, mug.gid, hoodie.gid] }
      let(:expected_response) do
        {
          'data' => {'discount' => '24.0', 'normal_price' => '92.0', 'total' => '68.0'}
        }
      end

      it 'returns price for requested items' do
        expect(json_response).to include(expected_response)
      end
    end

    context 'with invalid gids' do
      let(:items_gids) { ['100500'] }

      it 'returns error response code' do
        expect(response.code).to eq('404')
      end

      it 'returns error message' do
        expect(json_response).to include('errors' => ["Couldn't find Item"])
      end
    end
  end
end
