describe ItemsPrice::GroupItems do
  subject(:call) { described_class.(gids: items_gids) }

  let(:items_gids) { [mug.gid, t_shirt.gid, t_shirt.gid, t_shirt.gid, t_shirt.gid, mug.gid, hoodie.gid] }
  let(:mug) { create(:item, :mug) }
  let(:t_shirt) { create(:item, :t_shirt) }
  let(:hoodie) { create(:item, :hoodie) }

  it 'returns group items by count' do
    expect(call.grouped_items).to eq(mug => 2, t_shirt => 4, hoodie => 1)
  end
end
