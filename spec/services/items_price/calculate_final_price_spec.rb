describe ItemsPrice::CalculateFinalPrice do
  subject(:call) { described_class.(discount: discount, normal_price: normal_price) }

  let(:discount) { 30 }
  let(:normal_price) { 90 }

  it 'returns data with price details' do
    expect(call.data).to eq(discount: 30, normal_price: 90, total: 60)
  end
end
