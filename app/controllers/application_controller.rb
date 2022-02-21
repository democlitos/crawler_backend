class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      # Compare the tokens in a time-constant manner, to mitigate
      # timing attacks.
      p token
      p ENV['ACCESS_TOKEN']
      ActiveSupport::SecurityUtils.secure_compare(token, ENV['ACCESS_TOKEN'])
    end
  end
end
