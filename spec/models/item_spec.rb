describe Item, :model do
  describe '#serialize' do
    subject(:serialize) { item.serialize }

    let(:item) { create(:item, :mug) }

    it 'returns serialized attributes' do
      serialized_attributes = {'code' => 'MUG', 'name' => 'Reedsy Mug', 'price' => 6,
                               'gid' => '883a9cdc-a6ad-40b7-a68b-8f029a21d2e8'}
      expect(serialize).to eq(serialized_attributes)
    end
  end
end
