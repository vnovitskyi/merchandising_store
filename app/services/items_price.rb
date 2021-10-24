class ItemsPrice < BaseInteractor
  include ::Interactor::Organizer

  organize GroupItems,
           CalculateNormalPrice,
           CalculateDiscounts,
           CalculateFinalPrice
end
