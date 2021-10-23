class Item < ApplicationRecord
  CODES = %w[MUG TSHIRT HOODIE].freeze
  include SignificantAttributes

  validates :code, presence: true, uniqueness: true, inclusion: {in: CODES}
  validates :name, presence: true
  validates :price, presence: true, numericality: {greater_than: 0, less_than: 10_000}

  def serialize
    significant_attributes
  end
end
