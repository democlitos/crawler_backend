class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      # Compare the tokens in a time-constant manner, to mitigate
      # timing attacks.
      ActiveSupport::SecurityUtils.secure_compare(token, ENV['ACCESS_TOKEN'])
    end
  end
end
