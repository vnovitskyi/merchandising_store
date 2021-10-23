FactoryBot.define do
  factory :item do
    code { 'TSHIRT' }
    name { 'Reedsy T-shirt ' }
    price { 15 }
    gid { 'f492a901-9946-4816-a17b-17a01df0c99e' }

    trait :mug do
      code { 'MUG' }
      name { 'Reedsy Mug' }
      price { 6 }
      gid { '883a9cdc-a6ad-40b7-a68b-8f029a21d2e8' }
    end

    trait :hoodie do
      code { 'HOODIE' }
      name { 'Reedsy Hoodie ' }
      price { 20 }
      gid { 'ed995ee2-9e35-46a7-8e6d-f12cfbf246c5' }
    end
  end
end
