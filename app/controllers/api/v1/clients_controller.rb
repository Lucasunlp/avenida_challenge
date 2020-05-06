class Api::V1::ClientsController < ApiController
  before_action :authenticate, except: %i[create]

  # GET /api/v1/clients
  def index
    response_formater Api::V1::Clients::Index.new.call(params)
  end

  # POST /api/v1/clients
  def create
    client = Client.new(client_params)
    client.save ? (render json: client, status: :created) : (error_response(client.errors.messages))
  rescue StandardError
    error_response('Something went wrong!')
  end

  # PATCH /api/v1/clients/1
  def update
    render json: @current_user, status: :ok if @current_user.update(client_params)
  end

  # GET /api/v1/clients/1
  def show
    response_formater Api::V1::Clients::Show.new.call(params[:id])
  end

  # DELETE /api/v1/clients/1
  def destroy
    @current_user.destroy
    head 204
  end

  private

  def client_params
    params.require(:client).permit(:id, :full_name, :email, :id_card, :phone,
                                   :address, :api_token)
  end

  def error_response(errors)
    render status: 400, json: {
      status: 'error',
      notifications: errors
    }.to_json
  end

end
