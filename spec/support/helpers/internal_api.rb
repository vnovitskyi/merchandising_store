module InternalApiHelpers
  def post_api(path, params = {}, headers = {})
    post path, params: params.merge(format: :json), headers: headers
  end

  def put_api(path, params = {}, headers = {})
    put path, params: params.to_json, headers: {'CONTENT_TYPE' => 'application/json'}.merge(headers)
  end

  def json_response
    JSON(response.body)
  end
end

RSpec.configure do |config|
  config.include InternalApiHelpers, type: :api
end
