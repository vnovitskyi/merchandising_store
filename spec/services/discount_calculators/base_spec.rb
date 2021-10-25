describe DiscountCalculators::Base do
  let(:base_calculator) { described_class.new(discount, items) }
  let(:items) { [build(:item)] }
  let(:discount) { build(:discount) }

  describe '#calculate_discount' do
    subject(:calculate_discount) { base_calculator.calculate_discount }

    it 'raises error' do
      expect { calculate_discount }.to raise_error(NotImplementedError)
    end
  end
end
