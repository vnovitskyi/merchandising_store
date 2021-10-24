FactoryBot.define do
  factory :discount do
    type { 'Discounts::Percentage' }
    purchase_item_quantity { 3 }
    percent_discount { 30 }
  end

  factory :percentage_discount, class: 'Discounts::Percentage' do
    type { 'Discounts::Percentage' }
    purchase_item_quantity { 3 }
    percent_discount { 30 }
  end

  factory :free_item_discount, class: 'Discounts::FreeItem' do
    type { 'Discounts::FreeItem' }
    purchase_item_quantity { 2 }
    free_item_quantity { 1 }
  end
end
