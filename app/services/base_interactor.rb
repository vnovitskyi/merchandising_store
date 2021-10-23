class BaseInteractor
  include Interactor

  alias input context
  alias output context

  def fail!(message = nil)
    context.fail! message: message
  end
end
