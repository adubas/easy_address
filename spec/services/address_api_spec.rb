# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressApi do
  it 'returns address info' do
    address_json = {
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

    url = 'https://viacep.com.br/ws/02418100/json/'

    stub_request(:get, url).to_return(body: address_json, status: 200)

    result = AddressApi.call('02418100')

    expect(result['logradouro']).to eq 'Rua Bento Gonçalves'
    expect(result['bairro']).to eq 'Centro'
    expect(result['localidade']).to eq 'Camaquã'
    expect(result['uf']).to eq 'RS'
    expect(result['complemento']).to eq '1320'
    expect(result['ibge']).to eq '4303509'
    expect(result['gia']).to eq '234'
    expect(result['ddd']).to eq '53'
    expect(result['siafi']).to eq '23432'
  end

  it "returns error when doesn't find any info" do
    address_json = {
      "mesage": 'not found',
    }.to_json

    url = 'https://viacep.com.br/ws/02418100/json/'

    stub_request(:get, url).to_return(body: address_json, status: 404)

    expect do
      AddressApi.call('02418100')
    end.to raise_error(AddressApi::Error, 'Failed to retrieve address information for CEP 02418100')
  end

  it 'when API request gets timeout' do
    url = 'https://viacep.com.br/ws/02418100/json/'

    stub_request(:get, url).to_timeout

    expect do
      AddressApi.call('02418100')
    end.to raise_error(AddressApi::Error,
                       'Timeout error occurred while retrieving address information for CEP 02418100')
  end
end
