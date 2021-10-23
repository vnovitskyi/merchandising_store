class APIController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, &->(error) { render_exception(422, error) }
  rescue_from ActiveRecord::RecordNotFound, &->(error) { render_exception(404, error) }

  private

  def render_context(context)
    if context.success?
      render_data(context.data)
    else
      render_errors(context.status, context.errors)
    end
  end

  def render_data(data)
    render json: {data: data}
  end

  def render_exception(status, exception)
    render_errors(status, [exception.message])
  end

  def render_errors(status, errors)
    render status: status, json: {errors: errors}
  end
end
