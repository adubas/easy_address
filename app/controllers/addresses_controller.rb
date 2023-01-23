class AddressesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    json_data = JSON.parse(request.body.read, symbolize_names: true)

    addresses = json_data.map do |user_info|
      address_info = AddressApi.call(user_info[:cep])
      UserAddress.create_or_update(user_info, address_info)
    end

    render json: { status: 'success', addresses: }, status: :created
  rescue AddressApi::Error => e
    render json: { error: e.message }, status: :bad_request
  end
end
