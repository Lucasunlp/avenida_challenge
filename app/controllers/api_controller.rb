class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def response_formater(response)
    render json: response, status: response[:code]
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = Client.where(api_key: token).first
    end
  end
end
