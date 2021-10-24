describe ItemsPrice do
  subject(:call) { described_class.(gids: items_gids) }

  let(:items_gids) { [mug.gid, t_shirt.gid, t_shirt.gid, t_shirt.gid, t_shirt.gid, mug.gid, hoodie.gid] }
  let(:mug) { create(:item, :mug) }
  let(:t_shirt) { create(:item, :t_shirt) }
  let(:hoodie) { create(:item, :hoodie) }
  let(:free_item_discount) { create(:free_item_discount) }
  let(:percentage_discount) { create(:percentage_discount) }

  before do
    create(:item_discount, discount: free_item_discount, item: mug)
    create(:item_discount, discount: percentage_discount, item: t_shirt)
  end

  it 'returns data with price details' do
    expect(call.data).to eq(discount: 24, normal_price: 92, total: 68)
  end
end
