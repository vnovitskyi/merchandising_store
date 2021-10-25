describe Discount do
  describe '.scopes' do
    describe '.applicable_for_items' do
      subject { described_class.applicable_for_items(items) }

      let(:discount) { create(:percentage_discount) }
      let(:hoodie) { create(:item, :hoodie) }
      let(:t_shirt) { create(:item, :t_shirt) }

      before do
        create(:item_discount, discount: discount, item: hoodie)
      end

      context 'with items discount' do
        let(:items) { [hoodie] }

        it { is_expected.to eq([discount]) }
      end

      context 'without items discount' do
        let(:items) { [t_shirt] }

        it { is_expected.to be_blank }
      end
    end
  end
end
