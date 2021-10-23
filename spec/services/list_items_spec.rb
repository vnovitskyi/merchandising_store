describe ListItems do
  subject(:list_items) { described_class.() }

  let(:expected_data) do
    [{'code' => 'MUG', 'name' => 'Reedsy Mug', 'price' => 6, 'gid' => '883a9cdc-a6ad-40b7-a68b-8f029a21d2e8'},
     {'code' => 'HOODIE', 'name' => 'Reedsy Hoodie ', 'price' => 20, 'gid' => 'ed995ee2-9e35-46a7-8e6d-f12cfbf246c5'}]
  end

  before do
    create(:item, :mug)
    create(:item, :hoodie)
  end

  it 'returns data with serialized items' do
    expect(list_items.data).to eq(expected_data)
  end
end
