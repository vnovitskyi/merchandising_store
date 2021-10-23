describe UpdateItem do
  subject(:update_item) { described_class.(gid: gid, price: price) }

  let(:item) { create(:item, :mug) }
  let(:gid) { item.gid }
  let(:price) { 100 }

  context 'with valid price and item gid' do
    let(:expected_data) do
      {'code' => 'MUG', 'name' => 'Reedsy Mug', 'price' => 100, 'gid' => '883a9cdc-a6ad-40b7-a68b-8f029a21d2e8'}
    end

    it 'updates item price' do
      expect { update_item }.to change { item.reload.price }.to(100)
    end

    it 'returns data with serialized item' do
      expect(update_item.data).to eq(expected_data)
    end
  end

  context 'with invalid item gid' do
    let(:gid) { '100500' }

    it 'raises error' do
      expect { update_item }.to raise_error(ActiveRecord::RecordNotFound, "Couldn't find Item")
    end
  end

  context 'with invalid price' do
    let(:price) { 0 }

    it 'raises error' do
      expect { update_item }.to raise_error(ActiveRecord::RecordInvalid,
                                            'Validation failed: Price must be greater than 0')
    end
  end
end
