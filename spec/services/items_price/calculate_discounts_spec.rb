describe ItemsPrice::CalculateDiscounts do
  subject(:call) { described_class.(grouped_items: grouped_items) }

  let(:grouped_items) { {mug => 2} }
  let(:mug) { create(:item, :mug) }
  let(:percentage_discount) { create(:percentage_discount) }
  let(:free_item_discount) { create(:free_item_discount) }
  let(:discount_calculator) { instance_double(DiscountCalculator, calculate: 12) }

  before do
    allow(Discount).to receive(:applicable_for_items).and_return([percentage_discount, free_item_discount])
    allow(DiscountCalculator).to receive(:new).and_return(discount_calculator)
  end

  it 'returns sum of discount' do
    expect(call.discount).to eq(24)
  end
end
