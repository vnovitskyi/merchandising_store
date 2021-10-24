describe ItemsPrice::CalculateNormalPrice do
  subject(:call) { described_class.(grouped_items: grouped_items) }

  let(:grouped_items) { {mug => 2, t_shirt => 4, hoodie => 1} }
  let(:mug) { create(:item, :mug) }
  let(:t_shirt) { create(:item, :t_shirt) }
  let(:hoodie) { create(:item, :hoodie) }

  it 'returns total price without discounts' do
    expect(call.normal_price).to eq(92)
  end
end
