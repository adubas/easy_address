require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) do
      [{ 'cep': '02418100', 'name': 'JOÃO' }, { 'cep': '02418102', 'name': 'RAFAEL' },
       { 'cep': '02418103', 'name': 'MARIA' }].to_json
    end
    let(:valid_attribute) { [{ 'cep': '02418100', 'name': 'JOÃO' }].to_json }
    let(:conflicted_attributes) { [{ 'cep': '02418100', 'name': 'JOÃO' }, { 'cep': nil, 'name': nil }].to_json }
    let(:invalid_attributes) { [{ 'cep': nil, 'name': nil }].to_json }
    let(:json_response) do
      {
        "logradouro": 'Rua Bento Gonçalves',
        "bairro": 'Centro',
        "localidade": 'Camaquã',
        "uf": 'RS',
        "complemento": '1320',
        "ibge": '4303509',
        "gia": '234',
        "ddd": '53',
        "siafi": '23432',
      }.to_json
    end

    let(:empty_json_response) do
      {
        "invalid": '',
      }.to_json
    end

    context 'with valid params' do
      it 'creates a new UserAddress' do
        url1 = 'https://viacep.com.br/ws/02418100/json/'
        url2 = 'https://viacep.com.br/ws/02418102/json/'
        url3 = 'https://viacep.com.br/ws/02418103/json/'

        stub_request(:get, url1).to_return(body: json_response, status: 200)
        stub_request(:get, url2).to_return(body: json_response, status: 200)
        stub_request(:get, url3).to_return(body: json_response, status: 200)

        expect do
          post :create, body: valid_attributes
        end.to change(UserAddress, :count).by(3)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns a unprocessable_entity response' do
        url = 'https://viacep.com.br/json/'

        stub_request(:get, url).to_return(body: empty_json_response, status: 200)

        expect do
          post :create, body: invalid_attributes
        end.to_not change(UserAddress, :count)
        expect(response).to have_http_status(:created)
      end

      it 'returns a unprocessable_entity response with confliected responses' do
        url = 'https://viacep.com.br/ws/02418100/json/'
        error_url = 'https://viacep.com.br/json/'

        stub_request(:get, url).to_return(body: json_response, status: 200)
        stub_request(:get, error_url).to_return(body: empty_json_response, status: 200)

        expect do
          post :create, body: conflicted_attributes
        end.to change(UserAddress, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.body)
      end
    end

    context 'when AddressApi raises an error' do
      it 'returns a bad_request response when teh API returns timeout' do
        url = 'https://viacep.com.br/ws/02418100/json/'

        stub_request(:get, url).to_return(body: json_response, status: 404)

        post :create, body: valid_attributes
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a bad_request response when teh API returns timeout' do
        url = 'https://viacep.com.br/ws/02418100/json/'

        stub_request(:get, url).to_timeout

        post :create, body: valid_attributes
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
