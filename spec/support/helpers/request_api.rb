module RequestHelpers
  def api_get(path, params = {}, additional_headers = {})
    get path, params: params, headers: additional_headers
    json_response
  end

  def api_put(path, params = {}, additional_headers = {})
    put path, as: :json, params: params, headers: additional_headers
    json_response
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include RequestHelpers, type: :request
end
