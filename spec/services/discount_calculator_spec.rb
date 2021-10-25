describe DiscountCalculator do
  let(:discount_calculator) { described_class.new(discount, items) }
  let(:items) { [build(:item)] }

  describe '#calculate' do
    subject(:calculate) {        discount_calculator.calculate }

    let(:free_item_calculator) { instance_double(DiscountCalculators::FreeItem, calculate_discount: 50) }
    let(:percentage_calculator) { instance_double(DiscountCalculators::Percentage, calculate_discount: 49) }

    before do
      allow(DiscountCalculators::FreeItem).to receive(:new).and_return(free_item_calculator)
      allow(DiscountCalculators::Percentage).to receive(:new).and_return(percentage_calculator)
    end

    context 'when percentage discount' do
      let(:discount) { build(:percentage_discount) }

      it 'calls calculate_discount on percentage discount calculator' do
        calculate
        expect(percentage_calculator).to have_received(:calculate_discount)
      end

      it 'returns discount' do
        expect(calculate).to eq(49)
      end
    end

    context 'when free item discount' do
      let(:discount) { build(:free_item_discount) }

      it 'calls calculate_discount on free item discount calculator' do
        calculate
        expect(free_item_calculator).to have_received(:calculate_discount)
      end

      it 'returns discount' do
        expect(calculate).to eq(50)
      end
    end
  end
end
