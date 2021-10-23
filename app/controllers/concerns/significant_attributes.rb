module SignificantAttributes
  extend ActiveSupport::Concern

  HIDDEN_ATTRIBUTES = %w[id created_at updated_at].freeze

  def significant_attributes
    attributes.except(*HIDDEN_ATTRIBUTES)
  end
end
