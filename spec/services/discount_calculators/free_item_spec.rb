describe DiscountCalculators::FreeItem do
  let(:discount_calculator) { described_class.new(discount, items) }

  describe '#calculate_discount' do
    subject(:calculate_discount) { discount_calculator.calculate_discount }

    let(:discount) { create(:free_item_discount) }
    let(:mug) { create(:item, :mug) }
    let(:t_shirt) { create(:item, :t_shirt) }
    let(:hoodie) { create(:item, :hoodie) }

    before do
      create(:item_discount, discount: discount, item: mug)
      create(:item_discount, discount: discount, item: t_shirt)
    end

    context 'with discount items' do
      context 'when items quantity more or eql than discount purchase_item_quantity' do
        let(:items) do
          {mug => 3, t_shirt => 2, hoodie => 1}
        end

        it 'returns discount' do
          expect(calculate_discount).to eq(21)
        end
      end

      context 'when items quantity 2 times more than discount purchase_item_quantity' do
        let(:items) do
          {mug => 4}
        end

        it 'returns discount' do
          expect(calculate_discount).to eq(12)
        end
      end

      context 'when items quantity less than discount purchase_item_quantity' do
        let(:items) do
          {mug => 1, t_shirt => 1, hoodie => 1}
        end

        it { is_expected.to eq(0) }
      end
    end

    context 'without discount items' do
      let(:items) do
        {hoodie => 1}
      end

      it { is_expected.to eq(0) }
    end
  end
end
