# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAddress, :type => :model do
  it 'is valid with valid attributes' do
    user_params = {
      cep: '02418100',
      name: 'JOSÉ',
    }
    address_params = {
      "logradouro": 'Rua Bento Gonçalves',
      "bairro": 'Centro',
      "localidade": 'Camaquã',
      "uf": 'RS',
      "complemento": '1320',
      "ibge": '4303509',
      "gia": '',
      "ddd": '53',
      "siafi": '',
    }

    expect(UserAddress.create_or_update(user_params, address_params)).to be_valid
  end

  it 'is not valid without a zip code' do
    user_params = {
      cep: nil,
      name: 'JOSÉ',
    }

    address_params = {
      "logradouro": 'Rua Bento Gonçalves',
      "bairro": 'Centro',
      "localidade": 'Camaquã',
      "uf": 'RS',
      "complemento": '1320',
      "ibge": '4303509',
      "gia": '',
      "ddd": '53',
      "siafi": '',
    }

    expect(UserAddress.create_or_update(user_params, address_params)).to_not be_valid
  end

  it 'is not valid without a name' do
    user_params = {
      cep: '02418100',
      name: nil,
    }

    address_params = {
      "logradouro": 'Rua Bento Gonçalves',
      "bairro": 'Centro',
      "localidade": 'Camaquã',
      "uf": 'RS',
      "complemento": '1320',
      "ibge": '4303509',
      "gia": '',
      "ddd": '53',
      "siafi": '',
    }

    expect(UserAddress.create_or_update(user_params, address_params)).to_not be_valid
  end

  it 'updates params when already exist' do
    FactoryBot.create(:user_address)

    user_params = {
      cep: '02418100',
      name: 'JOSÉ',
    }

    address_params = {
      'logradouro' => 'Rua Bento Gonçalves',
      'bairro' => 'Centro',
      'localidade' => 'Camaquã',
      'uf' => 'RS',
      'complemento' => '1324',
      'ibge' => '4303509',
      'gia' => '234',
      'ddd' => '55',
      'siafi' => '2345',
    }

    address = UserAddress.create_or_update(user_params, address_params)
    expect(address).to be_valid

    expect(address.complement).to eq('1324')
    expect(address.gia).to eq('234')
    expect(address.ddd).to eq('55')
    expect(address.siafi).to eq('2345')
  end
end
